//
//  LoginActivityTableViewController.swift
//  pass-share
//
//  Created by CY on 2019/5/8.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class LoginActivityTableViewController: UITableViewController {
    var credentialID: String?
    
    var activities = [Activity]()
    
    override func viewWillAppear(_ animated: Bool) {
        print("reloading data: activity child view")
        super.viewWillAppear(animated)
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        activities = Array(selectedLogin.activityArr)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        let cell = tableView.dequeueReusableCell(withIdentifier: "displayActivityTableViewCell", for: indexPath) as! DisplayActivityTableViewCell
        cell.activityLabel?.text = activities[indexPath.row].text
        cell.timeLabel?.text = formatter.string(from: activities[indexPath.row].time)
        return cell
    }
}
