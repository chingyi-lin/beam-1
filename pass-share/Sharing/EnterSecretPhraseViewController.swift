//
//  EnterSecretPhraseViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/21.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class EnterSecretPhraseViewController: UIViewController {
    var credentialID: String?
    var newAccess: Access?
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var secretPhraseTextField: UITextField!
    @IBOutlet weak var nextBtnBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        self.title = "Secret Phrase"
        // Adjust keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipientViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipientViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        secretPhraseTextField.becomeFirstResponder()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "enterSecretPhraseVCToConfirmSharingVC" {
            let nextVC = (segue.destination as! ConfirmSharingViewController)
            nextVC.credentialID = self.credentialID
            nextVC.newAccess = self.newAccess
        }
    }
    @IBAction func editDidChanged(_ sender: Any) {
        var formIsValid = true
        // TODO: Validation needs to more specific
        if let isTextEmpty = secretPhraseTextField.text?.isEmpty {
            formIsValid = !isTextEmpty
        }
        nextBtn.isEnabled = formIsValid
        updateBtnStyle(byStage: nextBtn.isEnabled)
    }
    @IBAction func clickNext(_ sender: Any) {
        newAccess!.secretPhrase = self.secretPhraseTextField.text!
        print("secretPhrase stored")
    }
    func updateBtnStyle(byStage isEnabled: Bool) {
        if (isEnabled) {
            nextBtn.alpha = 1
        } else {
            nextBtn.alpha = 0.5
        }
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.nextBtnBottomConstraint.constant = keyboardFrame.height + 12.00
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.nextBtnBottomConstraint.constant = 45.00
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
extension EnterSecretPhraseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
