//
//  Activity.swift
//  pass-share
//
//  Created by CY on 2019/4/28.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import Foundation
import RealmSwift

class Activity: Object {
    @objc dynamic var activityID = UUID().uuidString
    @objc dynamic var time = Date()
    @objc dynamic var text = ""
    @objc dynamic var isActionable = false
    @objc dynamic var shareInvitationID = ""
    
    override static func primaryKey() -> String? {
        return "activityID"
    }
    convenience init(_ text: String, _ isActionable: Bool, _ shareInvitationID: String) {
        self.init()
        self.text = text
        self.isActionable = isActionable
        self.shareInvitationID = shareInvitationID
    }
}

