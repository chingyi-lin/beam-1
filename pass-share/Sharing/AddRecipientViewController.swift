//
//  AddRecipientViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/17.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class AddRecipientViewController: UIViewController, UITextViewDelegate {
    
    var credentialID: String?
    var newContact = Contact()
    var newAccess = Access()
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var nextBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func cancel(_ sender: Any) {
        // Animation: right to left
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.isEnabled = false
        emailTextField.delegate = self
        messageTextView.delegate = self
        
        // Configure  Button
        updateBtnStyle(byStage: nextBtn.isEnabled)
        // Adjust keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipientViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipientViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        emailTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "addRecipientToSetDuration" {
            let nextVC = (segue.destination as! SetDurationViewController)
            nextVC.credentialID = credentialID
            nextVC.newAccess = newAccess
        }
    }
    
    @IBAction func saveAndNext(_ sender: Any) {
        newContact.email = emailTextField.text!
        newContact.name = "Jenny Z"
        newContact.initial = "JZ"
        RealmAPI.shared.write(data: newContact)
        newAccess.grantToEmail = emailTextField.text!
        print("new contact stored")
        print("access email assigned")
    }
    
    @IBAction func editDidChanged(_ sender: Any) {
        var formIsValid = true
        // TODO: Validation needs to more specific
        if let isTextEmpty = emailTextField.text?.isEmpty {
            formIsValid = !isTextEmpty
        }
        nextBtn.isEnabled = formIsValid
        updateBtnStyle(byStage: nextBtn.isEnabled)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTextView.text == "Message (optional)" {
            messageTextView.text = ""
            messageTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextView.text == "" {
            messageTextView.text = "Message (optional)"
            messageTextView.textColor = UIColor.lightGray
        }
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

extension AddRecipientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


