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
    // -----------------
    
    // Initializators -----------
    init(_ name: String) {
        self.name = name
        super.init()
    }
    // --------------------------
    
    // Function for NSCoding ----
    // I know how to save instance in file
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
    }
    // I know how to read instance with file
    required init?(coder aDecoder: NSCoder) {
        self.items = aDecoder.decodeObject(forKey: "Items") as! [CheckListItem]
        self.name = aDecoder.decodeObject(forKey: "Name") as! String
        super.init()
    }
    // --------------------------
    
    
}
