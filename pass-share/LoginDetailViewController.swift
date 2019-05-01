//
//  LoginDetailViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/15.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol LoginDetailViewControllerDelegate {
    func navigateToManageShareVC()
}

class LoginDetailViewController: UIViewController {
    
    var website: String?
    var username: String?
    var password: String?
    var credentialID: String?
    
    var loginDetailViewControllerDelegate: LoginDetailViewControllerDelegate?
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        websiteLabel.text = selectedLogin.domain
        usernameLabel.text = selectedLogin.username
        passwordLabel.text = "• • • • • • • • • •"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "loginDetailVCToManageShareVC" {
            let displayVC = segue.destination as! ManageShareViewController
            displayVC.credentialID = self.credentialID
        }
    }
    @IBAction func revealPassword(_ sender: Any) {
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        if self.passwordLabel.text?.contains("•")  ?? false {
            self.passwordLabel.text = selectedLogin.password
        } else {
            self.passwordLabel.text = "• • • • • • • • • •"
        }
        
    }
    
    @IBAction func clickShareWith(_ sender: Any) {
        loginDetailViewControllerDelegate!.navigateToManageShareVC()
    }
    
}
