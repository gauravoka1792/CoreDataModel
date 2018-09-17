//
//  Address+CoreDataProperties.swift
//  CoreDataModel
//
//  Created by include tech. on 7/17/18.
//  Copyright © 2018 include tech. All rights reserved.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var street: String?
    @NSManaged public var person: Person?

}
