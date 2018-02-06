//
//  GroceriesListTableViewController.swift
//  Groceries
//
//  Created by Erick Borges on 31/01/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit
import CoreData
import CoreSpotlight
import MobileCoreServices

class GroceriesListTableViewController: UITableViewController{
    
    
    //MARK: - Properties
    var items: [Item] = [Item]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // Update datasource fetching from CoreData
        self.updateDatasource()
    }
    
    // MARK: - DataSource

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
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DAOItem.sharedInstance.deleteItem(item: self.items[indexPath.row])
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Methods
    
    func updateDatasource(){
        // Fetch the Itens in Core Data and reload table view
        self.items = DAOItem.sharedInstance.fetchItems()
        self.tableView.reloadData()
    }
    
    //MARK: - Actions
    
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first,
                let itemToSave = textField.text else {
                    return
            }
            DAOItem.sharedInstance.addItem(withName: itemToSave)
            self.updateDatasource()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(cancel)
        alert.addAction(save)
        present(alert, animated: true)
    }
}

