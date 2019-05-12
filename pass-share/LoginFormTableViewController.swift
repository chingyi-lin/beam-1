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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var showBtn: UIButton!
    
    var sitenameIsEmtpyBefore = true
    var urlIsEmtpyBefore = true
    var usernameIsEmtpyBefore = true
    var passwordIsEmtpyBefore = true
    
    @IBAction func textFieldsEditDidChange(_ sender: Any) {
        loginFormTableDelegate.formEditDidBegin(textFields: textFields)
    }
    
    @IBAction func textFieldEditDidChange(_ sender: UITextField) {
        switch sender {
        case siteNameTextField:
            sitenameIsEmtpyBefore = triggerAnimationAndUpdateEmptyStatus(byCurrentStatus: sitenameIsEmtpyBefore, with: nameLabel, sender)
        case urlTextField:
            urlIsEmtpyBefore = triggerAnimationAndUpdateEmptyStatus(byCurrentStatus: urlIsEmtpyBefore, with: websiteLabel, sender)
        case usernameTextField:
            usernameIsEmtpyBefore = triggerAnimationAndUpdateEmptyStatus(byCurrentStatus: usernameIsEmtpyBefore, with: usernameLabel, sender)
        case passwordTextField:
            passwordIsEmtpyBefore = triggerAnimationAndUpdateEmptyStatus(byCurrentStatus: passwordIsEmtpyBefore, with: passwordLabel, sender)
        default:
            print("no match")
        }
    }
    @IBAction func showBtnClicked(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        if (passwordTextField.isSecureTextEntry) {
            showBtn.setTitle("SHOW", for: .normal)
        } else {
            showBtn.setTitle("HIDE", for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        siteNameTextField.delegate = self
        urlTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func triggerAnimationAndUpdateEmptyStatus(byCurrentStatus isEmptyBefore: Bool, with label: UILabel, _ sender: UITextField) -> Bool{
        if (isEmptyBefore && !sender.text!.isEmpty) {
            label.floatIn(dy: -18)
            return false
        }
        else if (!isEmptyBefore && sender.text!.isEmpty){
            label.floatOut()
            return true
        } else {
            return isEmptyBefore
        }
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
