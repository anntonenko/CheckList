//
//  IconPickerViewController.swift
//  CheckList
//
//  Created by getTrickS2 on 11/9/17.
//  Copyright © 2017 getTrickS2. All rights reserved.
//

import UIKit

// Protocol that send the icon to ListDetailViewController -----------------------
protocol IconPickerViewControllerDelegate: class {
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String)
}
// -------------------------------------------------------------------------------

class IconPickerViewController: UITableViewController {

    // Properties ------------------
    weak var delegate: IconPickerViewControllerDelegate?
    let icons = [
    "No Icon",
    "Appointments",
    "Birthdays",
    "Chores",
    "Drinks",
    "Folder",
    "Groceries",
    "Inbox",
    "Photos",
    "Trips"]
    // -----------------------------
    
    // Override function ----------------------------------------------------------------------------------------
    
    // I know how many cells must be
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return icons.count
    }
    
    // I invoked when intemface don't to know how fill cell with it indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        let iconName = icons[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = iconName
        cell.imageView?.image = UIImage(named: iconName)
        
        return cell
    }
    
    // I implement when row with it indexPath was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.iconPicker(self, didPick: icons[indexPath.row])
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // ----------------------------------------------------------------------------------------------------------------
}
