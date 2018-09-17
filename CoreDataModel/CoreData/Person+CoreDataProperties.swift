//
//  Person+CoreDataProperties.swift
//  CoreDataModel
//
//  Created by include tech. on 7/17/18.
//  Copyright © 2018 include tech. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var first: String?
    @NSManaged public var last: String?
    @NSManaged public var address: NSSet?

}

// MARK: Generated accessors for address
extension Person {

    @objc(addAddressObject:)
    @NSManaged public func addToAddress(_ value: Address)

    @objc(removeAddressObject:)
    @NSManaged public func removeFromAddress(_ value: Address)

    @objc(addAddress:)
    @NSManaged public func addToAddress(_ values: NSSet)

    @objc(removeAddress:)
    @NSManaged public func removeFromAddress(_ values: NSSet)

}
