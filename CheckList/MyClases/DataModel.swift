//
//  DataModel.swift
//  CheckList
//
//  Created by getTrickS2 on 10/31/17.
//  Copyright © 2017 getTrickS2. All rights reserved.
//

import Foundation

class DataModel {
    // Properties ---------
    var lists: [CheckList]
    var fileName: String
    // --------------------
    
    // Computed properties -----------------
    var indexOfSelectedCheckList: Int {
        get {
            return UserDefaults.standard.integer(forKey: "CheckListIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CheckListIndex")
            UserDefaults.standard.synchronize()
        }
    }
    // -------------------------------------
    
    // Initializatoros ------
    init(inFile fileName: String) {
        // Create empty masive of list
        lists = []
        self.fileName = fileName
        // The end of part 1
        // Part 2
        // Download masive of list from file
        loadCheckList()
        registerDefaults()
    }
    // ----------------------
    
    // Functions ---------------------
    func registerDefaults() {
        UserDefaults.standard.register(defaults: [ "CheckListIndex" : -1 ])
    }
    // -------------------------------
    
    // Save and load data ---------------------------------------------------------------------
    // I return the directory for program working
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    // I return the full name of file that you wont to create
    func dataFilePathOf() -> URL {
        return documentsDirectory().appendingPathComponent(fileName)
    }
    // You know what I do
    func saveCheckList() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: fileName)
        archiver.finishEncoding()
        data.write(to: dataFilePathOf(), atomically: true)
    }
    // You know what I do
    func loadCheckList() {
        // 1
        let path = dataFilePathOf()
        // 2
        if let data = try? Data(contentsOf: path) {
            // 3
            let unrchiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unrchiver.decodeObject(forKey: fileName) as! [CheckList]
            unrchiver.finishDecoding()
        }
    }
    // -------------------------------------------------------------------------------
}
