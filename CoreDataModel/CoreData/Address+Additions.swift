//
//  Address+Additions.swift
//  CoreDataModel
//
//  Created by include tech. on 7/11/18.
//  Copyright © 2018 include tech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension Address {
    
    
    
    
    private static let singleton = Address()
    class func sharedInstance() -> Address {
        return singleton
    }
    
    func saveToCoreData(completion: @escaping ((_ response: JSON, _ error: Error?) -> Void)){
        CoreModelAPI.sharedInstance().APICall { (response, error) in
            
            print("Response is : \(response)")
            let results = response["results"]
            let arrayElement = results[0]
            let location = arrayElement["location"]
            _ = Address.upsertWithInfo(info:results)
            _ = Person.upsertWithInfo(info: results)
            print ("CoreData File Saved In Path : \(String(describing: CoreDataStore.sharedInstance().persistentContainer.persistentStoreDescriptions.first?.url))")
//           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            if error == nil {
                completion(location,nil)
            }
            else {
                completion(JSON.null,error?.localizedDescription as? Error)
            }
         
        }
    }
    
}
