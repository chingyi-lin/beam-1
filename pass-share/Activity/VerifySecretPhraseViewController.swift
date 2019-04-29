//
//  VerifySecretPhraseViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/28.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class VerifySecretPhraseViewController: UIViewController, UITextFieldDelegate {
    
    var shareInvitationID: String?
    var activityID: String?
    var shareInvitation: ShareInvitation?
    
    @IBOutlet weak var verifyBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var secretPhraseTextField: UITextField!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var textFieldLabel: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        // Animation: right to left
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func verify(_ sender: Any) {
        if (shareInvitation!.verifySecretPhrase(secretPhraseTextField.text!)) {
            self.performSegue(withIdentifier: "verifySecretPhraseVCToLoginAddedVC", sender: sender)
        } else {
            // TODO: implement attempt limitation
            hintLabel.text = "Incorrect secret phrase."
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        shareInvitation = RealmAPI.shared.readShareInvitation(filterBy: shareInvitationID!)
        verifyBtn.isEnabled = false
        secretPhraseTextField.delegate = self
        
        // Configure  Button
        updateBtnStyle(byStage: verifyBtn.isEnabled)
        // Adjust keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(VerifySecretPhraseViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(VerifySecretPhraseViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Hide the label when the placeholder exists
        self.textFieldLabel.alpha = 0
        
        // CY: The line below breaks the animation. Temporarily removed.
        // secretPhraseTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "verifySecretPhraseVCToLoginAddedVC" {
            let displayVC = segue.destination as! LoginAddedViewController
            displayVC.shareInvitationID = self.shareInvitationID!
            displayVC.activityID = self.activityID!
        }
    }
    
    @IBAction func editDidChanged(_ sender: Any) {
        if let isTextEmpty = secretPhraseTextField.text?.isEmpty {
            verifyBtn.isEnabled = !isTextEmpty
            updateBtnStyle(byStage: verifyBtn.isEnabled)
            updateTextFieldLabel(isTextEmpty)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func updateBtnStyle(byStage isEnabled: Bool) {
        if (isEnabled) {
            verifyBtn.alpha = 1
        } else {
            verifyBtn.alpha = 0.5
        }
    }
    func updateTextFieldLabel(_ isTextEmpty: Bool) {
        if isTextEmpty {
            self.textFieldLabel.fadeOut()
        } else {
            self.textFieldLabel.fadeIn()
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
                        self.verifyBtnBottomConstraint.constant = keyboardFrame.height + 12.00
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.verifyBtnBottomConstraint.constant = 45.00
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
