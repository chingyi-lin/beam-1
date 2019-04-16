//
//  Access.swift
//  pass-share
//
//  Created by Dev on 2019/4/16.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import Foundation
import RealmSwift

class Access: Object {
//  TODO: Implement expiration date
//  duration = 0 means one-time only
    @objc dynamic var accessID = UUID().uuidString
    @objc dynamic var credentailID = ""
    @objc dynamic var receiverEmail = ""
    @objc dynamic var duration = 0
    @objc dynamic var canSee = false
    @objc dynamic var secretPhrase = ""
    
    override static func primaryKey() -> String? {
        return "accessID"
    }
    convenience init(_ credentailID: String, receiverEmail: String, _ duration: Int, _ canSee: Bool, _ secretPhrase: String) {
        self.init()
        self.credentailID = credentailID
        self.receiverEmail = receiverEmail
        self.duration = duration
        self.canSee = canSee
        self.secretPhrase = secretPhrase
    }
}
