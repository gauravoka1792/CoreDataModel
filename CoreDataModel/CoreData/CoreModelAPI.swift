//
//  CoreModelAPI.swift
//  CoreDataModel
//
//  Created by include tech. on 7/11/18.
//  Copyright © 2018 include tech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class CoreModelAPI {
    
    private static let singleton = CoreModelAPI()
    class func sharedInstance() -> CoreModelAPI {
        return singleton
    }
    
    
    func APICall(completion: @escaping ((_ response: JSON, _ error: Error?) -> Void)) {
        let url = URL(string:"https://randomuser.me/api/")
        Alamofire.request(url!).responseJSON
            {
                response in
                if let resultvalue =  response.result.value as? [String:AnyObject], response.result.error == nil {
                    
                    completion(JSON(resultvalue), nil)
                    print("resultvalue is : \(resultvalue)")
                }
                else {
                    completion(JSON.null, response.result.error)
                }
        }
        
    }
    
}
