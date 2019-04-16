//
//  LoginDetailViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/15.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class LoginDetailViewController: UIViewController {
    
    var website: String?
    var username: String?
    var password: String?
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        websiteLabel.text = website
        usernameLabel.text = username
        passwordLabel.text = password
    }
}
