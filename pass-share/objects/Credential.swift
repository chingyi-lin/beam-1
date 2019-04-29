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
    let activityArr = List<Activity>()
    
    override static func primaryKey() -> String? {
        return "credentialID"
    }
    convenience init(_ sitename: String, _ domain: String, _ username: String, _ password: String) {
        self.init()
        self.sitename = sitename
        self.domain = domain
        self.username = username
        self.password = password
        let activityText = "You saved " + sitename + " to Beam."
        let activity = Activity(activityText, false, self.credentialID)
        self.activityArr.append(activity)
    }
    
    convenience init(_ sitename: String, _ domain: String, _ username: String, _ password: String, _ activityText: String) {
        self.init()
        self.sitename = sitename
        self.domain = domain
        self.username = username
        self.password = password
        let activityText = activityText
        let activity = Activity(activityText, false, self.credentialID)
        self.activityArr.append(activity)
    }
    
    func addAccess(_ access: Access) {
        self.accessArr.append(access)
    }
    
    func addActivity(_ activity: Activity) {
        self.activityArr.append(activity)
    }
}
