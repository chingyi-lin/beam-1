//
//  LoginBlankStateViewController.swift
//  pass-share
//
//  Created by CY on 2019/5/6.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol LoginBlankStateViewControllerDelegate {
    func addBtnClicked()
}

class LoginBlankStateViewController: UIViewController {
    
    var loginBlankStateViewControllerDelegate: LoginBlankStateViewControllerDelegate!
    
    
    @IBAction func addNewLoginClicked(_ sender: Any) {
        loginBlankStateViewControllerDelegate.addBtnClicked()
    }
    
}
