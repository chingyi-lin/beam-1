//
//  ManageShareTableViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/17.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol ManageShareTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow accessID: String)
    func shareBtnClicked()
}

class ManageShareTableViewController: UITableViewController {
    var credentialID: String?
    var accessArr = [Access]()
    var manageShareTableViewControllerDelegate: ManageShareTableViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70.0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("reloading data: access child view")
        super.viewWillAppear(animated)
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        if (selectedLogin.accessArr.count == 0) {
            renderBlankState()
        }
        accessArr = [Access]()
        accessArr = Array(selectedLogin.accessArr)
        if (accessArr.count != 0 ) {
            removeBlankState()
        }
        self.tableView.reloadData()
        print("access fetched")
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row at index: \(indexPath.row)")
        manageShareTableViewControllerDelegate.rowDidSelect(identifierInSelectedRow: self.accessArr[indexPath.row].accessID)
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
        let contact = RealmAPI.shared.readContactByEmail(filterBy: accessArr[indexPath.row].grantToEmail)
        
        cell.receiverName.text = contact.name
        cell.receiverEmail.text = contact.email
        cell.status.text = accessArr[indexPath.row].status
        cell.accessID = accessArr[indexPath.row].accessID
        cell.profilePic.image = UIImage(named: contact.imgFileName + "_large_50")
        if (contact.imgFileName.contains("blank")) {
            cell.receiverInitial.text = contact.initial
        } else {
            cell.receiverInitial.text = ""
        }
        var durationText = ""
        switch accessArr[indexPath.row].duration {
        case 0:
            durationText = "One-time Only"
        case 1:
            durationText = "30 Days"
        case 2:
            durationText = "No Expiration"
        case 3:
            // TODO: custom date TBD
            durationText = "Custom Date"
        default:
            durationText = "Custom Date"
        }
        cell.duration.text = durationText
        
        return cell
    }
    func renderBlankState() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "shareBlankState") as! ShareBlankStateViewController
        tableView.separatorColor = UIColor.clear // will hide standard separators
        tableView.backgroundView = controller.view
        let button = PrimaryButton(frame: CGRect(x: 110, y: 300, width: 160, height: 40))
        button.addTarget(self, action: #selector(shareBtnClicked), for: .touchUpInside)
        let btnAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        let attributedTitle = NSMutableAttributedString(string: "SHARE", attributes: btnAttributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.center.x = self.view.center.x // for vertical
        self.view.addSubview(button)
    }
    
    func removeBlankState() {
        tableView.separatorColor = UIColor.gray // set separators back
        tableView.backgroundView = nil
        for subview in self.view.subviews {
            if subview is PrimaryButton {
                subview.removeFromSuperview()
            }
        }
    }
    
    @objc func shareBtnClicked() {
        manageShareTableViewControllerDelegate.shareBtnClicked()
    }
}
