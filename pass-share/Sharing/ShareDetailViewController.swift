//
//  ShareDetailViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/29.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol ShareDetailViewControllerDelegate {
    func revoke()
}

class ShareDetailViewController: UIViewController {
    
    var credentialID: String?
    var accessID: String?
    var access: Access?
    var shareDetailViewControllerDelegate: ShareDetailViewControllerDelegate?

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var receiverEmailLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var secretPhraseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Share Details"
        access = RealmAPI.shared.readAccess(filterBy: accessID!)
        let contact = RealmAPI.shared.readContactByEmail(filterBy: access!.grantToEmail)
        profilePic.image = UIImage(named: contact.imgFileName + "_large_50")
        nameLabel.text = contact.name
        receiverEmailLabel.text = access?.grantToEmail
        switch access?.duration {
            case 0:
                self.durationLabel.text = "One-time Only"
            case 1:
                self.durationLabel.text = "30 Days"
            case 2:
                self.durationLabel.text = "No Expiration"
            case 3:
                // TODO: custom date TBD
                self.durationLabel.text = "Custom Date"
            default:
                self.durationLabel.text = "Custom Date"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "shareDetailVCToUpdatePasswordVC" {
            let displayVC = segue.destination as! UpdatePasswordViewController
            displayVC.credentialID = self.credentialID
        }
    }
    
    @IBAction func revoke(_ sender: Any) {
        RealmAPI.shared.delete(data: access!)
        shareDetailViewControllerDelegate?.revoke()
    }
    @IBAction func revealSecretPhrase(_ sender: UIButton) {
        if self.secretPhraseLabel.text?.contains("•") ?? false {
            self.secretPhraseLabel.text = access?.secretPhrase
            sender.setTitle("HIDE", for: .normal)
        } else {
            self.secretPhraseLabel.text = "• • • • • • • • • • • • • • • •"
            sender.setTitle("SHOW", for: .normal)
        }
    }
    
    
}
