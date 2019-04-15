//
//  loginFormTableView.swift
//  pass-share
//
//  Created by CY on 2019/4/11.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol LoginFormTableDelegate {
    func formEditDidBegin(textFields: [UITextField])
}

class LoginFormTableViewController : UITableViewController {
    
    var loginFormTableDelegate: LoginFormTableDelegate!
    
    @IBOutlet weak var siteNameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var textFields: [UITextField]!
    
    
    @IBAction func textFieldEditDidBegin(_ sender: Any) {
        loginFormTableDelegate.formEditDidBegin(textFields: textFields)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        siteNameTextField.delegate = self
        urlTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
    }
}

extension LoginFormTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case siteNameTextField:
            urlTextField.becomeFirstResponder()
        case urlTextField:
            usernameTextField.becomeFirstResponder()
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
