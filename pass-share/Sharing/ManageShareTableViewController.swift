//
//  ManageShareTableViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/17.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class ManageShareTableViewController: UITableViewController {
    var credentialID: String?
    var accessArr = [Access]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reloading data: access child view")
        super.viewWillAppear(animated)
        accessArr = [Access]()
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        accessArr = Array(selectedLogin.accessArr)
        self.tableView.reloadData()
        print("access fetched")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageShareTableCell", for: indexPath) as! ManageShareTableCell
        // Configure the cell
        let contact = RealmAPI.shared.readContact(filterBy: accessArr[indexPath.row].grantToEmail)
        cell.receiverInitial.text = contact.initial
        cell.receiverName.text = contact.name
        cell.receiverEmail.text = contact.email
        cell.status.text = accessArr[indexPath.row].status
        cell.accessID = accessArr[indexPath.row].accessID
        // Set up duration btn - need to adjust alignment
        let style = NSMutableParagraphStyle()
        var durationText = NSMutableAttributedString()
        style.alignment = NSTextAlignment.right
        switch accessArr[indexPath.row].duration {
            case 0:
                durationText = NSMutableAttributedString(string: "One-time Only", attributes: [ NSAttributedString.Key.paragraphStyle: style ])
            case 1:
                durationText = NSMutableAttributedString(string: "30 Days", attributes: [ NSAttributedString.Key.paragraphStyle: style ])
            case 2:
                durationText = NSMutableAttributedString(string: "No Expiration", attributes: [ NSAttributedString.Key.paragraphStyle: style ])
            case 3:
                // TODO: custom date TBD
                durationText = NSMutableAttributedString(string: "Custom Date", attributes: [ NSAttributedString.Key.paragraphStyle: style ])
            default:
                durationText = NSMutableAttributedString(string: "Custom Date", attributes: [ NSAttributedString.Key.paragraphStyle: style ])
        }
        cell.duration.setAttributedTitle(durationText, for: UIControl.State.normal)
        
        // TODO: implement revoke actions
        
        return cell
    }
    
}
