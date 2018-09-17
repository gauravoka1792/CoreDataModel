//
//  dataFetchController.swift
//  CoreDataModel
//
//  Created by include tech. on 7/13/18.
//  Copyright © 2018 include tech. All rights reserved.
//

import Foundation
import CoreData

class dataFetchController {
    
    private static let singleton = dataFetchController()
    class func sharedInstance() -> dataFetchController {
        return singleton
    }
    
     lazy var fetchedResultsController: NSFetchedResultsController<Address> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Address> = Address.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"city", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStore.managedObjectContext(), sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self as! NSFetchedResultsControllerDelegate 
        
        return fetchedResultsController
    }()
    
    
}
