//
//  SetSecretPhraseViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/21.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class SetSecretPhraseViewController: UIViewController {
    
    var credentialID: String?
    var newAccess: Access?
    
    override func viewDidLoad() {
        self.title = "Secret Phrase"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "setSecretPhraseVCToEnterSecretPhraseVC" {
            let nextVC = (segue.destination as! EnterSecretPhraseViewController)
            nextVC.credentialID = self.credentialID
            nextVC.newAccess = self.newAccess
        }
        if segue.identifier == "setSecretPhraseVCToConfirmSharingVC" {
            let nextVC = (segue.destination as! ConfirmSharingViewController)
            nextVC.credentialID = self.credentialID
            nextVC.newAccess = self.newAccess
        }
    }
}
