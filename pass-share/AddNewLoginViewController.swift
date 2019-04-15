//
//  AddNewLoginViewController.swift
//  pass-share
//
//  Created by CY on 2019/3/25.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
class AddNewLoginViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIButton!
    
    var loginFormTableViewController: LoginFormTableViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "loginFormEmbedSegue" {
            loginFormTableViewController = (segue.destination as! LoginFormTableViewController)
            loginFormTableViewController?.loginFormTableDelegate = self
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if let sitename = loginFormTableViewController?.siteNameTextField.text,
            let domain = loginFormTableViewController?.urlTextField.text,
            let username = loginFormTableViewController?.usernameTextField.text,
            let password = loginFormTableViewController?.passwordTextField.text {
                let credential = Credential(sitename, domain, username, password)
                let credentialRecord = credential.createCKRecord()
                CloudKitAPI.shared.sync(credentialRecord)
                RealmAPI.shared.write(data: credential)
                print("Saved. Going to the detail page")
//                dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "addNewLoginToLoginDetail", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Save Button
        saveButton.isEnabled = false
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
    }
}


