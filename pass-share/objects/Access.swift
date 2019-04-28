//
//  Access.swift
//  pass-share
//
//  Created by CY on 2019/4/16.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import Foundation
import RealmSwift

class Access: Object {
//  duration = 0 means one-time only
    @objc dynamic var accessID = UUID().uuidString
    @objc dynamic var grantToEmail = ""
    @objc dynamic var duration = 0
    @objc dynamic var canSee = false
    @objc dynamic var secretPhrase = ""
    @objc dynamic var status = "Pending Receipt"
    @objc dynamic var expirationDate = ""
    
    override static func primaryKey() -> String? {
        return "accessID"
    }
    convenience init(_ grantToEmail: String, _ duration: Int, _ canSee: Bool, _ secretPhrase: String, _ status: String, _ expirationDate: String) {
        self.init()
        self.grantToEmail = grantToEmail
        self.duration = duration
        self.canSee = canSee
        self.secretPhrase = secretPhrase
        self.status = status
        self.expirationDate = expirationDate
    }
}
