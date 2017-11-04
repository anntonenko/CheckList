//
//  ItemDetailViewController.swift
//  CheckList
//
//  Created by getTrickS2 on 10/5/17.
//  Copyright © 2017 getTrickS2. All rights reserved.
//

import UIKit

// Protocol that send the data betwen two ViewControllers
protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: CheckListItem)
}

class ItemDetailViewController : UITableViewController, UITextFieldDelegate {
    // Properties ----------------------------------------
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: CheckListItem?
    // ---------------------------------------------------
    
    // Actions ------------------------------------------------------------------------
    @IBAction func cancel() {
        // I implement when cencel button will click
        // And I said to the delegate that cancel button will click
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        // I implement when done button will click
        // 1. If it is EditItem screen then :
        if let item = itemToEdit {
            // 2. I change item
            item.text = textField.text!
            // 3. I said to the delegate that done button will click in EditItem screen
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        } else {
            // 2. I create a new item
            let item = CheckListItem(textField.text!, false)
            // 3. I said to the delegate that done button will click
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
    // ----------------------------------------------------------------------------------
    
    // Override functions -------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if it is EditItem screen then :
        if let item = itemToEdit {
            // Configurations for EditItem screen
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
            // ---
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // This is on of the UITextField delegate methods. It is invoked every time the user changes the text,
    // whether by tapping on the keyboard or by cut/paste.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = newText.length > 0
        
        return true
    }
    
    // This method did not allow to select any rows in table view
    //override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    //    return nil
    //}
    // ----------------------------------------------------------------------------------------------------------
}

