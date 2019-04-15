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
        provideCredentialToAutoFill()
        setupBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("reloading data")
        let data = RealmAPI.shared.readAll()
        print(data.count)
    }
    
    func provideCredentialToAutoFill() {
        writeDemoData()
        let credential = RealmAPI.shared.read(filterBy: "demo_identifier")
        
        // Do any additional setup after loading the view, typically from a nib.
        let serviceIdentifier = ASCredentialServiceIdentifier.init(identifier: credential.domain, type: ASCredentialServiceIdentifier.IdentifierType.domain)
        let identity = ASPasswordCredentialIdentity.init(serviceIdentifier: serviceIdentifier, user: credential.username, recordIdentifier: credential.identifier)
        
        store.saveCredentialIdentities([identity]) { (bool, error) in
            print("saveCredentialIdentities done")
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
    
    func writeDemoData() {
        let credential = Credential()
        credential.identifier = "demo_identifier"
        credential.sitename = "demo_site"
        credential.username = "realm_demo_user"
        credential.domain = "twitter.com"
        credential.password = "demo1234"
        RealmAPI.shared.write(data: credential)
    }
    
    @objc func btnClick() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewLogin")
        present(vc!, animated: true, completion: nil)
    }
}
