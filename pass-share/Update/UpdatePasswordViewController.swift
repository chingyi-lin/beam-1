//
//  UpdatePasswordViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/29.
//  Copyright © 2019 Pass Share. All rights reserved.
//



import UIKit

class UpdatePasswordViewController: UIViewController {
    
    var credentialID: String?
    
    @IBOutlet weak var sitenameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var currentPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var launchBtnBottomConstraint: NSLayoutConstraint!
    
    @IBAction func generateNewPassword(_ sender: Any) {
        newPasswordTextField.text = generateRandomPassword()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let credential = RealmAPI.shared.readCredentialById(queryWith: credentialID!)
        sitenameLabel.text = credential.sitename
        usernameLabel.text = credential.username
        
        // Adjust keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipientViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipientViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let credential = RealmAPI.shared.readCredentialById(queryWith: credentialID!)
        if segue.identifier == "updatePasswordVCToUpdateWebVC" {
            let displayVC = segue.destination as! UpdateWebViewController
            displayVC.domain = credential.domain
        }
    }
    
    @IBAction func showPassword(_ sender: Any) {
        let credential = RealmAPI.shared.readCredentialById(queryWith: credentialID!)
        if self.currentPasswordLabel.text?.contains("•")  ?? false {
            self.currentPasswordLabel.text = credential.password
        } else {
            self.currentPasswordLabel.text = "• • • • • • • • • •"
        }
    }
    func generateRandomPassword() -> String {
        let passwordChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*"
        let len = 8
        let randomPassword = String((0..<len).compactMap{ _ in passwordChars.randomElement() })
        return randomPassword
    }
    
    @IBAction func launchWebView(_ sender: Any) {
        let alert = UIAlertController(title: "Allow Beam to copy the new password to your clipboard?", message: "When you update your password, you can paste your new password into the fields.", preferredStyle: .alert)
        
        // TODO: implement keyboard
        alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: {action in
            UIPasteboard.general.string = self.newPasswordTextField.text
            self.performSegue(withIdentifier: "updatePasswordVCToUpdateWebVC", sender: self)}))
        alert.addAction(UIAlertAction(title: "Don't allow", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.launchBtnBottomConstraint.constant = keyboardFrame.height + 12.00
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.launchBtnBottomConstraint.constant = 45.00
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension UpdatePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
