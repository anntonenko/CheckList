//
//  CheckList.swift
//  CheckList
//
//  Created by getTrickS2 on 10/26/17.
//  Copyright © 2017 getTrickS2. All rights reserved.
//

import UIKit

class CheckList: NSObject, NSCoding {
    
    // Properties ------
    var name: String
    var items: [CheckListItem] = []
    var iconName: String
    // -----------------
    
    // Computer properties -------------
    var countUncheckedItems: Int {
        var count = 0
        for item in items where !item.chacked {
            count += 1
        }
        return count
    }
    // ---------------------------------
    
    // Initializators -----------
    init(_ name: String, _ iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    // --------------------------
    
    // Function for NSCoding ----
    // I know how to save instance in file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(iconName, forKey: "IconName")
    }
    // I know how to read instance with file
    required init?(coder aDecoder: NSCoder) {
        self.items = aDecoder.decodeObject(forKey: "Items") as! [CheckListItem]
        self.name = aDecoder.decodeObject(forKey: "Name") as! String
        self.iconName = aDecoder.decodeObject(forKey: "IconName") as! String
        super.init()
    }
    // --------------------------
    
    
}
