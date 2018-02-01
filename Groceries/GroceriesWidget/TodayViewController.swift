//
//  TodayViewController.swift
//  GroceriesWidget
//
//  Created by Erick Borges on 01/02/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UITableViewController, NCWidgetProviding {
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch the Itens in Core Data and reload table view
        self.items = DAOItem.sharedInstance.fetchItems()
        self.tableView.reloadData()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
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
    
    
    
}
