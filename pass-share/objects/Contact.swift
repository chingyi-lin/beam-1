//
//  Contact.swift
//  pass-share
//
//  Created by CY on 2019/4/16.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import Foundation
import RealmSwift

// TODO: User ID should be store and the ID should be obtained from our central db
// TODO: Initial should be auto generated from name
class Contact: Object {
    @objc dynamic var contactID = UUID().uuidString
    @objc dynamic var initial = ""
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var imgFileName = ""

    override static func primaryKey() -> String? {
        return "contactID"
    }
    convenience init(_ initial: String, _ name: String, _ email: String, _ imgFileName: String) {
        self.init()
        self.initial = initial
        self.name = name
        self.email = email
        self.imgFileName = imgFileName
    }
}

