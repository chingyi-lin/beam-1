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
        // Do any additional setup after loading the view, typically from a nib.
        let serviceIdentifier = ASCredentialServiceIdentifier.init(identifier: "twitter.com", type: ASCredentialServiceIdentifier.IdentifierType.domain)
        let identity = ASPasswordCredentialIdentity.init(serviceIdentifier: serviceIdentifier, user: "j_appleseed", recordIdentifier: "j_appleseed")
        
        store.saveCredentialIdentities([identity]) { (bool, error) in
            print("saveCredentialIdentities done")
        }
    }
}

