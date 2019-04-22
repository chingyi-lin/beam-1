//
//  ManageShareTableViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/17.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol ManageShareTableViewControllerDelegate {
    
}

class ManageShareTableViewController: UITableViewController {
    var manageShareTableViewControllerDelegate: ManageShareTableViewControllerDelegate!
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
        cell.duration.setTitle(String(accessArr[indexPath.row].duration), for: UIControl.State.normal)
        cell.accessID = accessArr[indexPath.row].accessID
        
        // TODO: implement revoke actions
        
        return cell
    }
    
}
