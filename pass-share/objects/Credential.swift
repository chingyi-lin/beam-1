import Foundation
import RealmSwift

class Credential: Object {
    @objc dynamic var identifier = ""
    @objc dynamic var username = ""
    @objc dynamic var domain = ""
    @objc dynamic var password = ""
}
