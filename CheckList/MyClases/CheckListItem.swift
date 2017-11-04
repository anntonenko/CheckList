//
//  CheckListItem.swift
//  CheckList
//
//  Created by getTrickS2 on 9/26/17.
//  Copyright © 2017 getTrickS2. All rights reserved.
//

import Foundation

class CheckListItem : NSObject, NSCoding {
    // Properties -------
    var text : String
    var chacked : Bool
    // ------------------
    
    // Designated initializer -----------------
    init( _ text : String, _ chacked : Bool) {
        self.chacked = chacked
        self.text = text
        
        super.init()
    }
    // ----------------------------------------
    
    // Functions -------------
    func toggleChacked() {
        chacked = !chacked
    }
    // ----------------------
    
    // For NSCoding protocol -----------------------
    // I know how to save this class in the files
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(chacked, forKey: "Checked")
    }
    // I know how to read this class from the file
    required init?(coder aDecoder: NSCoder) {
        // Reade the data from CheckList.plist ---
        self.text = aDecoder.decodeObject(forKey: "Text") as! String
        self.chacked = aDecoder.decodeBool(forKey: "Checked")
        // ---
        
        super.init()
    }
    //----------------------------------------------
    
}
