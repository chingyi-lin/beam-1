//
//  SetSeePasswordViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/21.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class SetSeePasswordViewController: UIViewController {
    var credentialID: String?
    var newAccess: Access?
    
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "See Password"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "setSeePasswordVCToSetSecretPhraseVC" {
            let nextVC = (segue.destination as! SetSecretPhraseViewController)
            nextVC.newAccess = self.newAccess
            nextVC.credentialID = self.credentialID
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        print(sender.currentTitle!)
        if (sender.currentTitle == "Yes") {
            newAccess?.canSee = true
        } else {
            print("set can see to false")
            newAccess?.canSee = false
        }
        self.performSegue(withIdentifier: "setSeePasswordVCToSetSecretPhraseVC", sender: self)
    }
    
    
}
