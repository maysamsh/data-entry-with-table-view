//
//  TableViewController.swift
//  DataEntryWithTableView
//
//  Created by Maysam Shahsavari on 12/15/19.
//  Copyright © 2019 Maysam Shahsavari. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var nameCell: DataEntryCell!
    @IBOutlet weak var titleCell: DataEntryCell!
    @IBOutlet weak var ageCell: DataEntryCell!
    @IBOutlet weak var emailCell: DataEntryCell!
    @IBOutlet weak var addressCell: DataEntryCell!
    @IBOutlet weak var phoneCell: DataEntryCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        if nameCell.isValid {
            nameCell.clearWarning()
            
            let alert = UIAlertController(title: "\(nameCell.value!), would you like to save the form?", message: "It's a mock form, nothing will be saved", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .destructive, handler: nil))

            self.present(alert, animated: true)
            
        } else {
            nameCell.setWarning()
        }
    }

}
