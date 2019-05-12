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
    
    private var isEmtpyBefore = true
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var secretPhraseTextField: UITextField!
    @IBOutlet weak var nextBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var secretPhraseLabel: UILabel!
    
    override func viewDidLoad() {
        self.title = "Secret Phrase"
        nextBtn.isEnabled = false
        updateBtnStyle(byStage: nextBtn.isEnabled)
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
    @IBAction func editDidChanged(_ sender: UITextField) {
        var formIsValid = true
        if let isTextEmpty = secretPhraseTextField.text?.isEmpty {
            formIsValid = !isTextEmpty
        }
        nextBtn.isEnabled = formIsValid
        updateBtnStyle(byStage: nextBtn.isEnabled)
        isEmtpyBefore = triggerAnimationAndUpdateEmptyStatus(byCurrentStatus: isEmtpyBefore, with: secretPhraseLabel, sender)
    }
    @IBAction func clickNext(_ sender: Any) {
        newAccess!.secretPhrase = self.secretPhraseTextField.text!
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
extension EnterSecretPhraseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
