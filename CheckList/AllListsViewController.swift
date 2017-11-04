//
//  AllListsViewController.swift
//  CheckList
//
//  Created by getTrickS2 on 10/26/17.
//  Copyright © 2017 getTrickS2. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    // Properties -----------------------
    var dataModel: DataModel!
    // ----------------------------------
    
    // Override functions ------------------------------------------------------------------------------------------
    // I am invoking before the view controller will appear
    override func viewDidLoad() {
        super.viewDidLoad()
        // The following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    // I know how many cells will be in the screen
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.lists.count
    }
    // I invoked when intemface don't to know how fill cell with it indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = makeCell(for: tableView, withIdentifier: "Cell")
        // Configure the cell...
        cell.textLabel?.text = dataModel.lists[indexPath.row].name
        cell.accessoryType = .detailDisclosureButton
        cell.detailTextLabel?.text = "All Done :)"
        
        return cell
    }
    // I implement when row with it indexPath was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let checkList = dataModel.lists[indexPath.row]
        
        performSegue(withIdentifier: "ShowCheckList", sender: checkList)
        
        //tableView.deselectRow(at: indexPath, animated: true)
        
    }
    // I know how to make cell
    func makeCell(for tableView: UITableView, withIdentifier cellIdentifier: String) -> UITableViewCell {
        // if cell template with accepted identifier will be we are creating this cell else
        // we create cell with standert template
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // 1. Check "This segue is ShowCheckList or AddCheckList screen ? "
        if segue.identifier == "ShowCheckList" {
            // 2. Create controller of ShowCheckList screen
            let controller = segue.destination as! CheckListViewController
            // 3. Send to the controller a cell that was called one
            controller.checkList = sender as! CheckList
        } else if segue.identifier == "AddCheckList" {
            // 2. Create controller for NavigationController
            let navigationController = segue.destination as! UINavigationController
            // 3. Create corntoller of AddCheckList screen
            let controller = navigationController.topViewController as! ListDetailViewController
            // 4. Tell to controller of AddCheckList that I (AllListViewController) will your delegate
            controller.delegate = self
        }
    }
    
    // I know how to delete the any items
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 1. Delete in data bace
        dataModel.lists.remove(at: indexPath.row)
        // 2. Delete in inteface
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    // I invoked when "detail disclosure" button in any row will tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // 1. This is create navigation controller of ListDetailViewController
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "ListDetailNavigationController") as! UINavigationController
        // 2. Create instance of ListDetailViewController
        let controller = navigationController.topViewController as! ListDetailViewController
        // 3. Fill need information for edit
        controller.delegate = self
        controller.checkListToEdit = dataModel.lists[indexPath.row]
        // 4. This is call the navigation controller of ListDetailViewController
        present(navigationController, animated: true, completion: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        // Return false if you do not want the specified item to be editable.
        
        return true
    }*/
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // --------------------------------------------------------------------------------------------------------------------
    
    // For Delegate (protocol ListDetailViewControllerDelegete)--------------------------
    // I can dismiss your screan)
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    // I know what to do when you wont to add item
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checkList: CheckList) {
        let newRowIndex = dataModel.lists.count
        
        dataModel.lists.append(checkList)
        
        tableView.insertRows(at: [IndexPath(row: newRowIndex, section: 0)], with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    // I know what to do when you wont to edit item
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checkList: CheckList) {
        if let index = dataModel.lists.index(of: checkList) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel?.text = checkList.name
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    // --------------------------------------------------------------------------------------------------------------------
    
    
}



































