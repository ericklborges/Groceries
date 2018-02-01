//
//  Item+CoreDataProperties.swift
//  Groceries
//
//  Created by Matheus de Vasconcelos on 01/02/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var isDone: Bool

}
