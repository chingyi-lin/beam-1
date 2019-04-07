//
//  AddNewLoginViewController.swift
//  pass-share
//
//  Created by Dev on 2019/3/25.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
class AddNewLoginViewController: UIViewController {
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBAction func textEditBegin(_ sender: Any) {
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
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        let credential = Credential()
        credential.identifier = "demo_identifier"
        if let username = usernameTextField.text, let domain = urlTextField.text,
            let password = passwordTextField.text {
                credential.domain = domain
                credential.username = username
                credential.password = password
                CloudKitAPI.shared.sync(credential)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Save Button
        saveButton.isEnabled = false
        urlTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
    }
}

extension AddNewLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
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


