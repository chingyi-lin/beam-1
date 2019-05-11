//
//  LoginDetailViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/15.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

protocol LoginDetailViewControllerDelegate {
    func navigateToManageShareVC()
}

class LoginDetailViewController: UIViewController {
    
    var website: String?
    var username: String?
    var password: String?
    var credentialID: String?

    var loginDetailViewControllerDelegate: LoginDetailViewControllerDelegate?
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var sharedWithPic: UIImageView!
    @IBOutlet weak var sharedWithPicLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        websiteLabel.text = selectedLogin.domain
        usernameLabel.text = selectedLogin.username
        passwordLabel.text = "• • • • • • • • • •"
        
        let accessArr = selectedLogin.accessArr
        var prevImage = sharedWithPic!
        if (accessArr.count >= 1) {
            for i in 0..<accessArr.count {
                sharedWithPicLeadingConstraint.constant += 34
                moveImageView(&prevImage, offsetBy: 34)
                let contact = RealmAPI.shared.readContactByEmail(filterBy: accessArr[i].grantToEmail)
                prevImage = renderContactPic(nextTo: prevImage, offsetBy: -34, for: contact)
            }
        }
        if (selectedLogin.myAccess!.grantByEmail != "") {
            let contact = RealmAPI.shared.readContactByEmail(filterBy: selectedLogin.myAccess!.grantByEmail)
            sharedWithPic.image = UIImage(named: contact.imgFileName + "_medium_31")
            shareBtn.isEnabled = false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "loginDetailVCToManageShareVC" {
            let displayVC = segue.destination as! ManageShareViewController
            displayVC.credentialID = self.credentialID
        }
    }
    @IBAction func revealPassword(_ sender: Any) {
        let selectedLogin = RealmAPI.shared.read(filterBy: credentialID!)
        if self.passwordLabel.text?.contains("•")  ?? false {
            self.passwordLabel.text = selectedLogin.password
        } else {
            self.passwordLabel.text = "• • • • • • • • • •"
        }
        
    }
    
    @IBAction func clickShareWith(_ sender: Any) {
        loginDetailViewControllerDelegate!.navigateToManageShareVC()
    }
    func moveImageView(_ imageView: inout UIImageView, offsetBy offsetX: CGFloat) {
        let imageOrigin = imageView.frame.origin
        let imageSize = imageView.frame.size
        imageView.frame = CGRect(x: imageOrigin.x + offsetX, y: imageOrigin.y, width: imageSize.width, height: imageSize.height)
    }
    
    func renderContactPic(nextTo prevImage: UIImageView, offsetBy offsetX: CGFloat, for contact: Contact) -> UIImageView{
        let prevImageOrigin = prevImage.frame.origin
        let imageView = UIImageView()
        
        imageView.frame = CGRect(x: prevImageOrigin.x + offsetX, y: prevImageOrigin.y, width: 31, height: 31)
        view.addSubview(imageView)
        imageView.image = UIImage(named: contact.imgFileName + "_medium_31")
        
        return imageView
    }
}
