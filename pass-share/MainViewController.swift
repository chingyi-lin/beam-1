//
//  MainViewController.swift
//  pass-share
//
//  Created by CY on 2019/3/25.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
import AuthenticationServices

class MainViewController: UITabBarController {
    var btn : UIButton = UIButton()
    var store: ASCredentialIdentityStore = ASCredentialIdentityStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBadgeValue()
        setupBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Main view will appear")
        // Push credentials to auto fill when user is directed to the main page.
        provideCredentialToAutoFill()
    }
    
    //  TODO: Incremental update (look up supportsIncrementalUpdates)
    func provideCredentialToAutoFill() {
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let credentials = RealmAPI.shared.readAll()
        print(credentials.count)
        for credential in credentials {
            let serviceIdentifier = ASCredentialServiceIdentifier.init(identifier: credential.domain, type: ASCredentialServiceIdentifier.IdentifierType.domain)
            let identity = ASPasswordCredentialIdentity.init(serviceIdentifier: serviceIdentifier, user: credential.username, recordIdentifier: credential.credentialID)
            // TODO: error handling
//            store.saveCredentialIdentities([identity]) { (bool, error) in
//                if (!bool) {
//                    print(error)
//                }
//                print("saveCredentialIdentities done")
//            }
            store.saveCredentialIdentities([identity])
            print("providing \(identity.recordIdentifier!)")
        }
    }
    
    func setupBtn() {
        // Setting image
        let image = UIImage(named: "add-white")
        btn.setImage(image, for: .normal)
        
        // Setting btn position
        btn.frame.size = CGSize(width: 60, height: 60)
        btn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.height/2 - 15)
        
        // Adding btn to tab bar
        tabBar.addSubview(btn)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    }
    
    func setupBadgeValue() {
        if RealmAPI.shared.readAllShareInvitation().count != 0 {
            tabBar.items![3].badgeValue = String(RealmAPI.shared.readAllShareInvitation().count)
        } else {
            tabBar.items![3].badgeValue = nil
        }
    }
    
    // TODO: Delete this function. It's more demo purpose.
    func writeDemoData() {
        let credential = Credential()
        credential.sitename = "demo_site"
        credential.username = "realm_demo_user"
        credential.domain = "twitter.com"
        credential.password = "demo1234"
        RealmAPI.shared.write(data: credential)
    }
    
    @objc func btnClick() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewLogin") as! AddNewLoginViewController
//        vc.addNewLoginViewControllerDelegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
