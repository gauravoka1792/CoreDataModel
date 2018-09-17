//
//  CoreDataStore.swift
//  CoreDataModel
//
//  Created by include tech. on 7/11/18.
//  Copyright © 2018 include tech. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore {
    private static let singleton = CoreDataStore()
    
    class func sharedInstance() -> CoreDataStore {
        return singleton
    }
 
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    class func managedObjectContext() -> NSManagedObjectContext {
        return sharedInstance().persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

}
