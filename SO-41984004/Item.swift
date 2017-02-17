//
//  Item.swift
//  SO-41984004
//
//  Created by Abizer Nasir on 17/02/2017.
//  Copyright © 2017 Abizer Nasir. All rights reserved.
//

import UIKit
import CoreData

@objc(Item)
final class Item: NSManagedObject {
    @NSManaged var title: String

    static func insertInto(_ context: NSManagedObjectContext, title: String) {
        let item = Item(context: context)
        item.title = title
    }

    static func defaultFetchRequest() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(title), ascending: true)]

        return request
    }
}

