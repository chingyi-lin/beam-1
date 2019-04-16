//
//  BeamExtTableViewController.swift
//  credential-provider
//
//  Created by CY on 2019/4/15.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
import RealmSwift

protocol BeamExtTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow credentialId: String)
}
class BeamExtTablveViewController: UITableViewController {
    
    var beamExtTableViewControllerDelegate: BeamExtTableViewControllerDelegate!
    var credentials = [Credential]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 90.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        credentials = [Credential]()
        let queryResult = RealmAPI.shared.readAll()
        for data in queryResult {
            credentials.append(data)
            print(data.domain)
        }
        print(credentials.count)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row at index: \(indexPath.row)")
        beamExtTableViewControllerDelegate.rowDidSelect(identifierInSelectedRow: self.credentials[indexPath.row].credentialID)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentials.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeamExtTableViewCell", for: indexPath) as! BeamExtTableViewCell
        // Configure the cell
        print(credentials[indexPath.row].domain)
        cell.urlLabel.text = credentials[indexPath.row].domain
        cell.usernameLabel.text = credentials[indexPath.row].username
        cell.identifier = credentials[indexPath.row].credentialID
        cell.siteImage.image = UIImage(named: "sitelogo_default")
        cell.sharedWithImage.image = UIImage(named:"profile_pic_small_24")
        
        return cell
    }
}
