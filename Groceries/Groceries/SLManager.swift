//
//  SLManager.swift
//  Groceries
//
//  Created by Erick Borges on 01/02/2018.
//  Copyright © 2018 Erick Borges. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class SLManager {
    
    public static func setSpotlightIndexes(){
        let items = DAOItem.sharedInstance.fetchItems()
        
        CSSearchableIndex.default().deleteAllSearchableItems { (error) in
            guard error == nil else {
                print("Failed to deleteAllSearchableItems with error: \(error!.localizedDescription)")
                return
            }
        }
        
        for item in items {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
            attributeSet.keywords = ["Groceries", "Grocery", "Shop", "List"]
            attributeSet.title = item.name
            attributeSet.contentDescription = item.isDone ? "\(item.name!) was bought" : "\(item.name!) wasn't bought"
            attributeSet.thumbnailData = item.isDone ? UIImagePNGRepresentation(#imageLiteral(resourceName: "Check")) : UIImagePNGRepresentation(#imageLiteral(resourceName: "Uncheck"))
            let item = CSSearchableItem(uniqueIdentifier: item.name!, domainIdentifier: nil, attributeSet: attributeSet)
            
            CSSearchableIndex.default().indexSearchableItems([item], completionHandler: { (error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
            })
        }
    }
}
