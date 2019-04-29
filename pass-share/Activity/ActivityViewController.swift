//
//  ActivityViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/28.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    var activityTableViewController: ActivityTableViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "activityTableViewEmbedSegue" {
            activityTableViewController = (segue.destination as! ActivityTableViewController)
            activityTableViewController?.activityTableViewControllerDelegate = self
            print("Delegating activity table view")
        }
    }
    
}

extension ActivityViewController: ActivityTableViewControllerDelegate {
    func acceptSharing(with shareInvitationID: String) {
        print("accept!")
        print(shareInvitationID)
    }
}
