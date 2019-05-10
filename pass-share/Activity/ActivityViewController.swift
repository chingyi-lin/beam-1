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
    var shareInvitationID: String?
    var activityID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "activityTableViewEmbedSegue" {
            activityTableViewController = (segue.destination as! ActivityTableViewController)
            activityTableViewController?.activityTableViewControllerDelegate = self
            print("Delegating activity table view")
        }
        if segue.identifier == "activityVCToVerifySecretPhraseVC" {
            let displayVC = (segue.destination as! VerifySecretPhraseViewController)
            displayVC.shareInvitationID = self.shareInvitationID
            displayVC.activityID = self.activityID
        }
    }
    
}

extension ActivityViewController: ActivityTableViewControllerDelegate {
    func acceptSharing(with shareInvitationID: String, _ activityID: String) {
        self.shareInvitationID = shareInvitationID
        self.activityID = activityID
        self.performSegue(withIdentifier: "activityVCToVerifySecretPhraseVC", sender: self)
    }
}
