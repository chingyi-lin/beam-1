//
//  BeamTableViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/14.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
import RealmSwift

protocol BeamTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow credentialId: String)
}

// TODO: implement deletion
class BeamTableViewController: UITableViewController {
    
    var beamTableViewControllerDelegate: BeamTableViewControllerDelegate!
    var credentials = [Credential]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 90.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reloading data: child view")
        super.viewWillAppear(animated)
        print("credential empty")
        credentials = [Credential]()
        let queryResult = RealmAPI.shared.readAll()
        for data in queryResult {
            credentials.append(data)
        }
        self.tableView.reloadData()
        print("crednetial fetched")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row at index: \(indexPath.row)")
        beamTableViewControllerDelegate.rowDidSelect(identifierInSelectedRow: self.credentials[indexPath.row].credentialID)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentials.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeamTableViewCell", for: indexPath) as! BeamTableViewCell
        // Configure the cell

        cell.sitenameLabel.text = credentials[indexPath.row].sitename
        cell.usernameLabel.text = credentials[indexPath.row].username
        cell.identifier = credentials[indexPath.row].credentialID

        return cell
    }
}
