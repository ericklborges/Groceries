//
//  GroceriesListTableViewController.swift
//  Groceries
//
//  Created by Erick Borges on 31/01/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit
import CoreData

class GroceriesListTableViewController: UITableViewController {

    
    //MARK: - Class Properties
    var items: [Item] = [Item]()
    
    //MARK: - UITableViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Navigation With Large Text
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Add an edit button in the left of Navigation Controller
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // Update datasource fetching from CoreData
        self.updateDatasource()
    }
    
    func updateDatasource(){
        // Fetch the Itens in Core Data and reload table view
        var stringOpt : String?
        stringOpt = "weightCache"
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: nil)
        self.items = DAOItem.sharedInstance.fetchItems()
        self.tableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func addItem(_ sender: Any) {
        self.updateDatasource()
//        let alert = UIAlertController(title: "New Item",
//                                      message: nil,
//                                      preferredStyle: .alert)
//
//        let save = UIAlertAction(title: "Save",
//                                       style: .default) {
//                                        [unowned self] action in
//
//                                        guard let textField = alert.textFields?.first,
//                                            let itemToSave = textField.text else {
//                                                return
//                                        }
//
//                                        DAOItem.sharedInstance.addItem(withName: itemToSave)
//                                        self.items = DAOItem.sharedInstance.fetchItems()
//                                        self.tableView.reloadData()
//        }
//
//        let cancel = UIAlertAction(title: "Cancel",
//                                         style: .cancel)
//
//        alert.addTextField()
//
//        alert.addAction(cancel)
//        alert.addAction(save)
//
//        present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! GroceriesListTableViewCell
        
        cell.outletItemNameLabel.text = items[indexPath.row].name
        cell.outletCheckButton.isSelected = items[indexPath.row].isDone
        cell.item = items[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete Item from Core Data
            DAOItem.sharedInstance.deleteItem(item: self.items[indexPath.row])
            // Delete Item from itens array
            self.items.remove(at: indexPath.row)
            // Delete the row from the data source
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
}
