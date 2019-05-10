//
//  AddNewLoginViewController.swift
//  pass-share
//
//  Created by CY on 2019/3/25.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class AddNewLoginViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonBottomConstraint: NSLayoutConstraint!
    
    var credentialID: String?
    
    var loginFormTableViewController: LoginFormTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Save Button
        saveButton.isEnabled = false
        
        // Configure  Button
        updateBtnStyle(byStage: saveButton.isEnabled)
        // Adjust keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewLoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddNewLoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "loginFormEmbedSegue" {
            loginFormTableViewController = (segue.destination as! LoginFormTableViewController)
            loginFormTableViewController?.loginFormTableDelegate = self
        }
        if segue.identifier == "addNewLoginToLoginDetail" {
            let displayVC = (segue.destination as! LoginViewController)
            displayVC.credentialID = self.credentialID
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if let sitename = loginFormTableViewController?.siteNameTextField.text,
            let domain = loginFormTableViewController?.urlTextField.text?.lowercased(),
            let username = loginFormTableViewController?.usernameTextField.text,
            let password = loginFormTableViewController?.passwordTextField.text {
                let credential = Credential(sitename, domain, username, password)
                let credentialRecord = credential.createCKRecord()
                CloudKitAPI.shared.sync(credentialRecord)
                RealmAPI.shared.write(data: credential)
                credentialID = credential.credentialID
//                self.performSegue(withIdentifier: "addNewLoginToLoginDetail", sender: self)
            
                dismiss(animated: true, completion: nil)
        }
    }
    
    func updateBtnStyle(byStage isEnabled: Bool) {
        if (isEnabled) {
            print(isEnabled)
            saveButton.alpha = 1
        } else {
            saveButton.alpha = 0.5
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.saveButtonBottomConstraint.constant = keyboardFrame.height + 12.00
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.saveButtonBottomConstraint.constant = 45.00
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension AddNewLoginViewController: LoginFormTableDelegate {
    func formEditDidBegin(textFields: [UITextField]) {
        var formIsValid = true
        // TODO: Validation needs to more specific
        for textField in textFields {
            if let isTextEmpty = textField.text?.isEmpty {
                formIsValid = !isTextEmpty
            } else {
                break
            }
        }
        saveButton.isEnabled = formIsValid
        updateBtnStyle(byStage: saveButton.isEnabled)
    }
}
