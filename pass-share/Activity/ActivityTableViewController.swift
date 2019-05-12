//
//  ActivityTableViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/28.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol ActivityTableViewControllerDelegate {
    func acceptSharing(with shareInvitationID: String, _ activityID: String)
}

class ActivityTableViewController: UITableViewController {
    var activityTableViewControllerDelegate: ActivityTableViewControllerDelegate!
    var activities = [Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reloading data: activity child view")
        super.viewWillAppear(animated)
        activities = [Activity]()
        let queryResult = RealmAPI.shared.readAllActivity()
        for data in queryResult {
            activities.append(data)
        }
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if activities[indexPath.row].isActionable {
            return 140.0
        } else {
            return 60.0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        if activities[indexPath.row].isActionable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "actionableActivityTableViewCell", for: indexPath) as! ActionableActivityTableViewCell
            cell.shareInvitationID = activities[indexPath.row].shareInvitationID
            cell.activityID = activities[indexPath.row].activityID
            cell.actionableActivityTableViewCellDelegate = self
            cell.activityLabel?.text = activities[indexPath.row].text
            cell.timeLabel?.text = formatter.string(from: activities[indexPath.row].time)
            cell.declineBtn.layer.borderColor = UIColor(red:0.06, green:0.11, blue:0.28, alpha:1.0).cgColor
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "displayActivityTableViewCell", for: indexPath) as! DisplayActivityTableViewCell
            cell.activityLabel?.text = activities[indexPath.row].text
            cell.timeLabel?.text = formatter.string(from: activities[indexPath.row].time)
            return cell
        }
    }
}

extension ActivityTableViewController: ActionableActivityTableViewCellDelegate {
    func acceptSharing(with shareInvitationID: String, _ activityID: String) {
        activityTableViewControllerDelegate.acceptSharing(with: shareInvitationID, activityID)
    }
}
