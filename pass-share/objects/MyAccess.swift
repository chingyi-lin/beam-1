//
//  MyAccess.swift
//  pass-share
//
//  Created by CY on 2019/4/17.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import Foundation
import RealmSwift

class MyAccess: Object {
    @objc dynamic var isOwn = false
    @objc dynamic var grantBy = ""
    @objc dynamic var access: Access?
    
    convenience init(_ isOwn: Bool, _ grantBy: String, _ access: Access) {
        self.init()
        self.isOwn = isOwn
        self.grantBy = grantBy
        self.access = access
    }
    
    convenience init(_ isOwn: Bool, _ grantBy: String) {
        self.init()
        self.isOwn = isOwn
        self.grantBy = grantBy
    }
}
