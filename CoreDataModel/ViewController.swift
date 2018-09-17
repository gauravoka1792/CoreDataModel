//
//  ViewController.swift
//  CoreDataModel
//
//  Created by include tech. on 7/10/18.
//  Copyright © 2018 include tech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    var results = [Address]()
    
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Address> = {
    // Create Fetch Request
        let fetchRequest: NSFetchRequest<Address> = Address.fetchRequest()
    // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"city", ascending: true)]
    // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStore.managedObjectContext(), sectionNameKeyPath: nil, cacheName: nil)
    // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: "Cell")
//        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

        Address.sharedInstance().saveToCoreData{(response,error) in
            self.performInitialFetch()
            self.tableView.reloadData()
        }
        //Address.sharedInstance().saveToCoreData()
  
    }
//    
//    @objc func loadList(){
//        //load data here
//        self.performInitialFetch()
//        self.tableView.reloadData()
//    }

    
    // MARK:- Helper Methods
    
    private func performInitialFetch() {
        do {
            try   self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
}

    // MARK:- TableView Delegates

    extension ViewController : UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            guard let resultValue = fetchedResultsController.fetchedObjects else { return 0 }
            print("ResultValue is : \(resultValue)")
            return resultValue.count
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddressTableViewCell
        
            let result = fetchedResultsController.object(at: indexPath)
        
            if let city = result.city, let street = result.street, let state = result.state {
                cell.lblcity.text = city
                cell.lblstreet.text = street
                cell.lblstate.text = state
                
//                cell.lblcity.text = "city"
//                cell.lblstreet.text = "street"
//                cell.lblstate.text = "state"
            
            }
//        if let res = Address.allObjects() {
//        results = res
//        }
            
        return cell
    }
}

    extension ViewController: NSFetchedResultsControllerDelegate {
    
        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        }
    
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       tableView.reloadData()
        }
}
