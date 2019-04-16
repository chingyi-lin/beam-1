//
//  CredentialProviderViewController.swift
//  credential-provider
//
//  Created by PT on 2019/3/22.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import AuthenticationServices
import RealmSwift


class CredentialProviderViewController: ASCredentialProviderViewController {
    
    var beamExtTableViewController: BeamExtTablveViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "beamExtTableEmbedSegue" {
            beamExtTableViewController = (segue.destination as! BeamExtTablveViewController)
            beamExtTableViewController?.beamExtTableViewControllerDelegate = self
            print("Delegating beamexttableview")
        }
    }

    /*
     Prepare your UI to list available credentials for the user to choose from. The items in
     'serviceIdentifiers' describe the service the user is logging in to, so your extension can
     prioritize the most relevant credentials in the list.
    */
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
    }

    /*
     Implement this method if your extension supports showing credentials in the QuickType bar.
     When the user selects a credential from your app, this method will be called with the
     ASPasswordCredentialIdentity your app has previously saved to the ASCredentialIdentityStore.
     Provide the password by completing the extension request with the associated ASPasswordCredential.
     If using the credential would require showing custom UI for authenticating the user, cancel
     the request with error code ASExtensionError.userInteractionRequired.
    */
    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {
        let databaseIsUnlocked = true
        if (databaseIsUnlocked) {
            let credential = RealmAPI.shared.read(filterBy: credentialIdentity.recordIdentifier!)
            print("in provider: \(credentialIdentity.recordIdentifier!)")
            let passwordCredential = ASPasswordCredential(user: credential.username, password: credential.password)
            self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
        } else {
            self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code:ASExtensionError.userInteractionRequired.rawValue))
        }
    }
 
 

    /*
     Implement this method if provideCredentialWithoutUserInteraction(for:) can fail with
     ASExtensionError.userInteractionRequired. In this case, the system may present your extension's
     UI and call this method. Show appropriate UI for authenticating the user then provide the password
     by completing the extension request with the associated ASPasswordCredential.

    override func prepareInterfaceToProvideCredential(for credentialIdentity: ASPasswordCredentialIdentity) {
    }
    */

    @IBAction func cancel(_ sender: AnyObject?) {
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }
}

extension CredentialProviderViewController: BeamExtTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow credentialId: String) {
        print("Select the row with id as \(credentialId)")
        let databaseIsUnlocked = true
        if (databaseIsUnlocked) {
            let credential = RealmAPI.shared.read(filterBy: credentialId)
        print("serving : \(credential.username)")
        let passwordCredential = ASPasswordCredential(user: credential.username, password: credential.password)
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
        } else {
            self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code:ASExtensionError.userInteractionRequired.rawValue))
        }
    }
}
