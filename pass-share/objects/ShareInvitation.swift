//
//  SharedCredential.swift
//  pass-share
//
//  Created by CY on 2019/4/28.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import Foundation
import RealmSwift

class ShareInvitation: Object {
    // TODO: need a way to know who owns this credential
    @objc dynamic var shareInvitationID = UUID().uuidString
    @objc dynamic var senderName = ""
    @objc dynamic var sitename = ""
    @objc dynamic var domain = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var duration = 0
    @objc dynamic var canSee = false
    @objc dynamic var secretPhrase = ""
    
    override static func primaryKey() -> String? {
        return "shareInvitationID"
    }
    convenience init(_ senderName: String, _ sitename: String, _ domain: String, _ username: String, _ password: String, _ duration: Int, _ canSee: Bool, _ secretPhrase: String) {
        self.init()
        self.senderName = senderName
        self.sitename = sitename
        self.domain = domain
        self.username = username
        self.password = password
        self.duration = duration
        self.canSee = canSee
        self.secretPhrase = secretPhrase
    }
    
    // TODO: using secretPhrase to decrypt encrypted password
    func verifySecretPhrase(_ secretPhrase: String) -> Bool{
        if self.secretPhrase == secretPhrase {
            // TODO: The text is too long and the row height needs to auto sizing to fit it.
            // let activityText = "You accepted the " + sitename + " login shared from " + senderName + "."
            let activityText = "You accepted " + senderName + "'s " + sitename + " login."
            let credential = Credential(sitename, domain, username, password, activityText)
            RealmAPI.shared.write(data: credential)
            return true
        } else {
            return false
        }
    }
}
