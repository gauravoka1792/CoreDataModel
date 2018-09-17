//
//  NSManagedObjects+Additions.swift
//  CoreDataModel
//
//  Created by include tech. on 7/11/18.
//  Copyright © 2018 include tech. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

extension NSManagedObject {
    class func entityName() -> String {
        
        return "Address"
    }
    // Creates a new blank object
    class func newObject() -> NSManagedObject {
        
        if( self == Address.self ) {
        let moc = CoreDataStore.managedObjectContext()
        let entity = NSEntityDescription.entity(forEntityName: "Address", in: moc)
        let object = NSManagedObject(entity: entity!, insertInto: moc)
        
            return object
        }
        else if( self == Person.self) {
            let moc = CoreDataStore.managedObjectContext()
            let entity = NSEntityDescription.entity(forEntityName: "Person", in: moc)
            let object = NSManagedObject(entity: entity!, insertInto: moc)
            
            return object
        }
        return  0 as! NSManagedObject
    }
    
    func updateWithInfo(info: JSON) {
  
        for (key, _) in info {
            if(key == "location") {
                
                for (key, value) in info["location"] {
                    if (self.responds(to: Selector(key))) {
                        self.setValue(value.string, forKeyPath: key)
                    }
                }
            }
            else if(key == "name") {
                for (key, value) in info["name"] {
                    if (self.responds(to: Selector(key))) {
                        self.setValue(value.string, forKeyPath: key)
                    }
                }
            }
        }
        
    }
    
    // Returns all objects for an entity name
    class func allObjects() -> [AnyObject]? {
        
        let moc = CoreDataStore.managedObjectContext()
        let entity = NSEntityDescription.entity(forEntityName: self.entityName(), in: moc)
        let fetchReq = NSFetchRequest<NSFetchRequestResult>()
        fetchReq.entity = entity
        fetchReq.predicate = NSPredicate(format: "city != nil")
        
        var fetched :[AnyObject]?
        do {
            try fetched = moc.fetch(fetchReq) as [AnyObject]
        } catch _ as NSError { }
        
        return fetched
    }
    
    // Return a single object that matches a given name
    class func fetchObjectWithName(param: String) -> AnyObject? {
        
        if (self == Address.self) {
        let moc = CoreDataStore.managedObjectContext()
        let entity = NSEntityDescription.entity(forEntityName: "Address", in: moc)
        let fetchReq = NSFetchRequest<NSFetchRequestResult>()
        fetchReq.entity = entity
        fetchReq.fetchLimit = 1
        fetchReq.predicate = NSPredicate(format: "city like [c] %@", param)
        
        var fetched :[AnyObject]?
        do {
            try fetched = moc.fetch(fetchReq) as [AnyObject]
        } catch _ as NSError { }
        
        return fetched?.first
        }
        else if (self == Person.self ) {
            let moc = CoreDataStore.managedObjectContext()
            let entity = NSEntityDescription.entity(forEntityName: "Person", in: moc)
            let fetchReq = NSFetchRequest<NSFetchRequestResult>()
            let first = "first"
            fetchReq.entity = entity
            fetchReq.fetchLimit = 1
            fetchReq.predicate = NSPredicate(format: "%@ like [c] %@", first, param)
            
            var fetched :[AnyObject]?
            do {
                try fetched = moc.fetch(fetchReq) as [AnyObject]
            } catch _ as NSError { }
            
            return fetched?.first
            
        }
        return nil
    }
    
    // Update if exists, create new one if noe
    class func upsertWithInfo(info: JSON) -> NSManagedObject? {
        if(self == Address.self) {
        var obj: NSManagedObject? = nil
        let arrayElement = info[0]
        let location = arrayElement["location"]
        if let city = location["city"].string {
            
            if let existing = fetchObjectWithName(param: city) as? NSManagedObject {
                obj = existing
            } else {
                obj = newObject()
            }
            
            obj?.updateWithInfo(info: arrayElement)
            CoreDataStore.sharedInstance().saveContext()
        }
        return obj
    }
        else if(self == Person.self) {
            var obj: NSManagedObject? = nil
            let arrayElement = info[0]
            let location = arrayElement["name"]
            if let name = location["first"].string {
                
                if let existing = fetchObjectWithName(param: name) as? NSManagedObject {
                    obj = existing
                } else {
                    obj = newObject()
                }
                
                obj?.updateWithInfo(info: arrayElement)
                CoreDataStore.sharedInstance().saveContext()
            }
            return obj

        }
       return nil
    }
}
