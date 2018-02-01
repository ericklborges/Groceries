//
//  GroceriesListTableViewCell.swift
//  Groceries
//
//  Created by Erick Borges on 31/01/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit

class GroceriesListTableViewCell: UITableViewCell {

    var item: Item!
    @IBOutlet weak var outletItemNameLabel: UILabel!
    @IBOutlet weak var outletCheckButton: UIButton!
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        DAOItem.sharedInstance.updateCheck(to: sender.isSelected, on: item)
    }
    
}
