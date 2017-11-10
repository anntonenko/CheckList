//
//  ListDetailViewController.swift
//  CheckList
//
//  Created by getTrickS2 on 10/27/17.
//  Copyright © 2017 getTrickS2. All rights reserved.
//

import UIKit

// Protocol that send the data betwen two ViewControllers (ListDetailViewController and any class that implement this protocol)
protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checkList: CheckList)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checkList: CheckList)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {

    // Properties ----------------------------------------
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    weak var delegate: ListDetailViewControllerDelegate?
    var checkListToEdit: CheckList?
    var iconName = "Folder"
    // ---------------------------------------------------
    
    // Actions --------------------
    // Action for cancel button
    @IBAction func cancel() {
        // I implement when cencel button will click
        // And I said to the delegate that cancel button will click
        delegate?.listDetailViewControllerDidCancel(self)
    }
    // Action for done or add buttons
    @IBAction func done() {
        // I implement when done button will click
        // 1. If it is EditItem screen then :
        if let checkList = checkListToEdit {
            // 2. I change item
            checkList.name = textField.text!//MARK if done will shared will return nil?
            checkList.iconName = iconName
            // 3. I said to the delegate that done button will click in EditItem screen
            delegate?.listDetailViewController(self, didFinishEditing: checkList)
        } else {
            // 2. I create a new item
            let checkList = CheckList(textField.text!, iconName)
            // 3. I said to the delegate that done button will click
            delegate?.listDetailViewController(self, didFinishAdding: checkList)
        }
    }
    
    // ----------------------------
    
    // Override functions ----------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // If user wont to edit checkList:
        if let checkList = checkListToEdit {
            title = "Edit CheckList"
            textField.text = checkList.name
            doneBarButton.isEnabled = true
            iconName = checkList.iconName
        }
        // Edit image
        iconImageView.image = UIImage(named: iconName)
    }
    // I do the textField is first responder
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK if this method try in viewDidLoad? It is works!
        textField.becomeFirstResponder()
    }
    
    // This is on of the UITextField delegate methods. It is invoked every time the user changes the text,
    // whether by tapping on the keyboard or by cut/paste.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = (newText.length > 0)
        
        return true
    }
    
    // I don't allow to tap on any section besides 1 (To choose an icon)
     override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print(indexPath.section)
        if indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PickIcon" {
            let controller = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
    

    // --------------------------------------------------------------------------------------------------------------
    
    // For IconPickerViewController delegate -----------------------------------------
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
        self.iconName = iconName
        iconImageView.image = UIImage(named: iconName)
        let _ = navigationController?.popViewController(animated: true)
    }
    // -------------------------------------------------------------------------------
}
