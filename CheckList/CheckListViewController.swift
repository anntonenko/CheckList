//
//  ViewController.swift
//  CheckList
//
//  Created by getTrickS2 on 9/25/17.
//  Copyright © 2017 getTrickS2. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, ItemDetailViewControllerDelegate {
    // Properties --------------------------------
    var checkList: CheckList! // data sorce
    // -------------------------------------------
    
    //Override functions --------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init name of navigation controller
        title = checkList?.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // I return count of cells
        return checkList.items.count
    }
    
    // I implement when intemface don't to know how fill cell with it indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get variables
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        let item = checkList.items[indexPath.row]
        
        //Write data in cells
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        // It is returning configuration cell
        return cell
    }
    
    // I implement when row with it indexPath was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Get variables
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checkList.items[indexPath.row]
            //Update data and view
            item.toggleChacked()
            configureCheckmark(for: cell, with: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // I know how to delete the any items
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 1. Delete in data bace
        checkList.items.remove(at: indexPath.row)
        // 2. Delete in inteface
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    // I implement when user go on to any another screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. Check "Is it AddItem or EditItem screen ? "
        if segue.identifier == "AddItem" {
            // 2. That is creation weird variable :)
            let navigationController = segue.destination as! UINavigationController
            // 3. Create corntoller of AddItem screen
            let controller = navigationController.topViewController as! ItemDetailViewController
            // 4. Tell to controller of AddItem that I (CheckListViewController) will your delegate
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            // 2. That is creation weird variable :)
            let navigationController = segue.destination as! UINavigationController
            // 3. Create corntoller of AddItem screen
            let controller = navigationController.topViewController as! ItemDetailViewController
            // 4. Tell to controller of AddItem that I (CheckListViewController) will your delegate
            controller.delegate = self
            // 5. We try to know which row was sender
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checkList.items[indexPath.row]
            }
        }
    }
    // --------------------------------------------------------------------------------------------------
    
    // Function for navigate each Chack List Item-------------------------------------
    func configureCheckmark(for cell : UITableViewCell, with item : CheckListItem) {
        // Create checkmark lable
        let lable = cell.viewWithTag(1001) as! UILabel
        // Set checkmark lable
        if item.chacked {
            lable.text = "✔️"
        } else {
            lable.text = ""
        }
    }
    
    func configureText(for cell : UITableViewCell, with item : CheckListItem) {
        // Create checkmark lable
        let lable = cell.viewWithTag(1000) as! UILabel
        // Set checkmark lable
        lable.text = item.text
    }
    //--------------------------------------------------------------------------------
    
    // For Delegate (protocol ItemDetailViewControllerDelegete)--------------------------
    // I can dismiss your screan)
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    // I know what to do when you wont to add item
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: CheckListItem) {
        // Add item ---
        let newRowIndex = checkList.items.count
        // Add to data base
        checkList.items.append(item)
        // Add to interface
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        //Close the add window
        dismiss(animated: true, completion: nil)
    }
    // I know what to do when you wont to edit item
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: CheckListItem) {
        // Let create index than indexPath and than a cell that we wont to edit
        if let index = checkList.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        // close the edit window
        dismiss(animated: true, completion: nil)
    }
    // -------------------------------------------------------------------------------
    
}












