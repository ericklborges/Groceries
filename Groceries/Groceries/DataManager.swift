//
//  DataManager.swift
//  Groceries
//
//  Created by Matheus de Vasconcelos on 01/02/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit
import CoreData

class PersinstentContainer: NSPersistentContainer{
    
    override class func defaultDirectoryURL() -> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.mackmobile.Groceries")!
    }
    
    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
    }
    
}

class DataManager: NSObject {
    
    // MARK: - Core Data stack
    
    public static var persistentContainer: PersinstentContainer = {
       let container = PersinstentContainer(name: "Groceries")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    public static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                SLManager.setSpotlightIndexes()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
