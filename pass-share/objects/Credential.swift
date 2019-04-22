import Foundation
import RealmSwift

class Credential: Object {
    // TODO: need a way to know who owns this credential
    @objc dynamic var credentialID = UUID().uuidString
    @objc dynamic var sitename = ""
    @objc dynamic var domain = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    let accessArr = List<Access>()
    
    override static func primaryKey() -> String? {
        return "credentialID"
    }
    convenience init(_ sitename: String, _ domain: String, _ username: String, _ password: String) {
        self.init()
        self.sitename = sitename
        self.domain = domain
        self.username = username
        self.password = password
    }
    
    func addAccess(_ access: Access) {
        self.accessArr.append(access)
    }
}
