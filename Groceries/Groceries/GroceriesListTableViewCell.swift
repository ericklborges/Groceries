//
//  GroceriesListTableViewCell.swift
//  Groceries
//
//  Created by Erick Borges on 31/01/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit

class GroceriesListTableViewCell: UITableViewCell {

    @IBOutlet weak var outletItemNameLabel: UILabel!
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
