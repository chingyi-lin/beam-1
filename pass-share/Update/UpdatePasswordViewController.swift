//
//  UpdatePasswordViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/29.
//  Copyright © 2019 Pass Share. All rights reserved.
//



import UIKit
import SafariServices

class UpdatePasswordViewController: UIViewController {
    
    var credentialID: String?
    fileprivate var request: AnyObject?
    
    @IBOutlet weak var siteLogo: UIImageView!
    @IBOutlet weak var sitenameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var currentPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var launchBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var launchBtn: UIButton!
    
    @IBAction func generateNewPassword(_ sender: Any) {
        newPasswordTextField.text = generateRandomPassword()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let credential = RealmAPI.shared.readCredentialById(queryWith: credentialID!)
        fetchSiteLogo(for: RealmAPI.shared.read(filterBy: credentialID!).domain)
        sitenameLabel.text = credential.sitename
        usernameLabel.text = credential.username
        
        let titleStr = "LAUNCH " + credential.sitename.uppercased() + " TO UPDATE PASSWORD"
        launchBtn.setTitle(titleStr, for: .normal)
        // Adjust keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipientViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipientViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        let credential = RealmAPI.shared.readCredentialById(queryWith: credentialID!)
        if self.currentPasswordLabel.text?.contains("•")  ?? false {
            self.currentPasswordLabel.text = credential.password
            sender.setTitle("HIDE", for: .normal)
        } else {
            self.currentPasswordLabel.text = "• • • • • • • • • •"
            sender.setTitle("SHOW", for: .normal)
        }
    }
    func generateRandomPassword() -> String {
        let passwordChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*"
        let len = 16
        let randomPassword = String((0..<len).compactMap{ _ in passwordChars.randomElement() })
        return randomPassword
    }
    
    @IBAction func launchWebView(_ sender: Any) {
        let alert = UIAlertController(title: "Allow Beam to copy the new password to your clipboard?", message: "When you update your password, you can paste your new password into the fields.", preferredStyle: .alert)
        
        // TODO: implement keyboard
        alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: {action in
            UIPasteboard.general.string = self.newPasswordTextField.text
            self.presentSafariWebView()
        }))
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .cancel, handler: {action in
            self.presentSafariWebView()
        }))
        
        self.present(alert, animated: true)
    }
    
    func presentSafariWebView(){
        let credential = RealmAPI.shared.readCredentialById(queryWith: credentialID!)
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        var urlString = ""
        switch credential.domain {
            case "instagram.com":
                urlString = "https://www.instagram.com/accounts/password/change/"
            default:
                urlString = "https://" + credential.domain
        }
        
        let url = URL(string: urlString)!
        let vc = SFSafariViewController(url: url, configuration: config)
        self.present(vc, animated: true)
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
    
    func fetchSiteLogo(for domain: String){
        let imgSource = "https://logo.clearbit.com/"
        let targetUrl = URL(string: imgSource + domain + "?size=65")!
        let siteLogoRequest = ImageRequest(url: targetUrl)
        self.request = siteLogoRequest
        siteLogoRequest.load(withCompletion: { [weak self] (siteLogo: UIImage?) in
            guard let siteLogo = siteLogo else {
                return
            }
            self?.siteLogo.image = siteLogo
        })
    }
}

extension UpdatePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
