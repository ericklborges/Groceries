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
    
    //MARK: - Properties
    var items = [Item]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set dinamic heigt for width
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        // Fetch the Itens in Core Data and reload table view
        updateDatasource()
        // Notification observer to update when oppened
        NotificationCenter.default.addObserver(self, selector: #selector(updateDatasource), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            let width = self.view.frame.width
            preferredContentSize = CGSize(width: width, height: width)
        } else {
            preferredContentSize = maxSize
        }
    }
    
    //MARK: - DataSource
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
    
    //MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.extensionContext?.open(URL(string: "Groceries://")!, completionHandler: nil)
    }
    
    //MARK: - Methods
    @objc
    func updateDatasource(){
        // Fetch the Itens in Core Data and reload table view
        self.items = DAOItem.sharedInstance.fetchItems()
        self.items = self.items.filter { (item) -> Bool in
            return !item.isDone
        }
        self.tableView.reloadData()
    }
    
    
}
