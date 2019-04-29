//
//  LoginAddedViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/29.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class LoginAddedViewController: UIViewController {
    
    var shareInvitationID: String = ""
    var activityID: String = ""

    @IBOutlet weak var durationDescriptionLabel: UILabel!
    @IBAction func done(_ sender: Any) {
        let shareInvite = RealmAPI.shared.readShareInvitation(filterBy: shareInvitationID)
        let activity = RealmAPI.shared.readActivity(filterBy: activityID)
        RealmAPI.shared.delete(data: shareInvite)
        RealmAPI.shared.delete(data: activity)
        
        self.performSegue(withIdentifier: "loginAddedVCToBeamVC", sender: self)
    }
    
    override func viewDidLoad() {
        let shareInvite = RealmAPI.shared.readShareInvitation(filterBy: shareInvitationID)
        
        switch shareInvite.duration {
            case 0:
                durationDescriptionLabel.text = "You have access for one-time only."
            case 1:
                durationDescriptionLabel.text = "You have access for 30 days."
            case 2:
                durationDescriptionLabel.text = "Your access has no expiration."
            case 3:
                // TODO: custom date TBD
                durationDescriptionLabel.text = "You have access until 2019/5/20."
            default:
                durationDescriptionLabel.text  = ""
        }
    }
}
