//
//  DAOItem.swift
//  Groceries
//
//  Created by Matheus de Vasconcelos on 01/02/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit
import CoreData

class DAOItem: NSObject {
    private let context = DataManager.persistentContainer.viewContext
    
    public static let sharedInstance = DAOItem()
    
    private override init(){ }
    
    public func addItem(withName name: String){
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context)
        newItem.setValue(name, forKey: "name")
        newItem.setValue(false, forKey: "isDone")
        DataManager.saveContext()
    }
    
    public func updateCheck(to state: Bool, on item: Item){
        item.setValue(state, forKey: "isDone")
        DataManager.saveContext()
    }
    
    public func fetchItems() -> [Item] {
        var parties = [Item]()
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                results.forEach({ (result) in
                    parties.append(result)
                })
            }
        }catch{
            print("Can't fetch Items")
        }
        return parties
    }
    
    public func deleteItem(item: Item){
        context.delete(item)
        DataManager.saveContext()
    }
    

}
