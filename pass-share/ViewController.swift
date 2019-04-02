//
//  ViewController.swift
//  pass-share
//
//  Created by Ching-Yi Lin on 2019/3/17.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
    
    var store: ASCredentialIdentityStore = ASCredentialIdentityStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeDemoData()
        let credential = RealmAPI.shared.read(filterBy: "demo_identifier")
        
        // Do any additional setup after loading the view, typically from a nib.
        let serviceIdentifier = ASCredentialServiceIdentifier.init(identifier: credential.domain, type: ASCredentialServiceIdentifier.IdentifierType.domain)
        let identity = ASPasswordCredentialIdentity.init(serviceIdentifier: serviceIdentifier, user: credential.username, recordIdentifier: credential.identifier)
        
        store.saveCredentialIdentities([identity]) { (bool, error) in
            print("saveCredentialIdentities done")
        }
    }
    
    func writeDemoData() {
        let credential = Credential()
        credential.identifier = "demo_identifier"
        credential.username = "realm_demo_user"
        credential.domain = "twitter.com"
        credential.password = "demo1234"
        RealmAPI.shared.write(data: credential)
    }
}

