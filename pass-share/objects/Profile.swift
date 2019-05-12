//
//  Settings.swift
//  pass-share
//
//  Created by CY on 2019/5/12.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import Foundation
import RealmSwift

class Profile: Object {
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var cloudSync = false
    
    convenience init(_ name: String, _ email: String, _ cloudSync: Bool) {
        self.init()
        self.name = name
        self.email = email
        self.cloudSync = cloudSync
    }
}
