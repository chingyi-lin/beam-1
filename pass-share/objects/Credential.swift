import Foundation
import RealmSwift

class Credential: Object {
    @objc dynamic var identifier = ""
    @objc dynamic var sitename = ""
    @objc dynamic var domain = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    
    convenience init(_ sitename: String, _ domain: String, _ username: String, _ password: String) {
        self.init()
        self.sitename = sitename
        self.domain = domain
        self.username = username
        self.password = password
        // TODO: Specify the correct record identifier.
        self.identifier = "demo_identifier"
    }
}
