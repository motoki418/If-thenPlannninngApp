//
//  Item+CoreDataProperties.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}

extension Item : Identifiable {

}
