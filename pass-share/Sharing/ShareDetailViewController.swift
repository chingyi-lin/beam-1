//
//  ShareDetailViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/29.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class ShareDetailViewController: UIViewController {
    
    var credentialID: String?
    var accessID: String?
    var access: Access?

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var receiverEmailLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var secretPhraseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Share Details"
        access = RealmAPI.shared.readAccess(filterBy: accessID!)
        let contact = RealmAPI.shared.readContact(filterBy: access!.grantToEmail)
        profilePic.image = UIImage(named: contact.imgFileName + "_large_50")
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
        let alert = UIAlertController(title: "Update Password?", message: "You’ve allowed the recipient to view the password, so we recommend updating your password after revoking their access.\n\nAll other sharers will automatically be synced with the new password.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: {action in self.performSegue(withIdentifier: "shareDetailVCToUpdatePasswordVC", sender: self)}))
        alert.addAction(UIAlertAction(title: "Not Now", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    @IBAction func revealSecretPhrase(_ sender: Any) {
        if self.secretPhraseLabel.text?.contains("•") ?? false {
            self.secretPhraseLabel.text = access?.secretPhrase
        } else {
            self.secretPhraseLabel.text = "• • • • • • • • • • • • • • • •"
        }
    }
    
    
}
