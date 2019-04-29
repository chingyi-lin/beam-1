import Foundation
import RealmSwift

final class RealmAPI {
    static let shared = RealmAPI()
    let realm: Realm;
    
    private init() {
        let fileManager = FileManager.default
        let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.passshare.pass-share")!
        let realmPath = directory.appendingPathComponent("db.realm")
        Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: realmPath)
        realm = try! Realm()
    }
    
    func write(data: Object) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func update(data: Object) {
        try! realm.write {
            realm.add(data, update: true)
        }
    }
    
    func appendAccessToCredential(for data: Credential, with access: Access) {
        try! realm.write {
            data.accessArr.append(access)
        }
    }
    
    func read(filterBy credentialID: String) -> Credential {
        return realm.objects(Credential.self).filter("credentialID = '\(credentialID)'").first!
    }
    
    func readCredentialById(queryWith credentialID: String) -> Credential {
        return realm.object(ofType: Credential.self, forPrimaryKey: credentialID)!
    }
    
    func readAccess(filterBy accessID: String) -> Access {
        return realm.objects(Access.self).filter("accessID = '\(accessID)'").first!
    }
    
    func readActivity(filterBy activityID: String) -> Activity {
        return realm.objects(Activity.self).filter("activityID = '\(activityID)'").first!
    }
    
    func readSharedInvitation(filterBy shareInvitationID: String) -> ShareInvitation {
        return realm.objects(ShareInvitation.self).filter("shareInvitationID = '\(shareInvitationID)'").first!
    }
    
    func readContact(filterBy contactEmail: String) -> Contact {
        return realm.objects(Contact.self).filter("email = '\(contactEmail)'").first!
    }
    
    func readAllActivity() -> Results<Activity> {
        return realm.objects(Activity.self)
    }
    
    func readAllSharedInvitation() -> Results<ShareInvitation> {
        return realm.objects(ShareInvitation.self)
    }
    
    func readAll() -> Results<Credential> {
        return realm.objects(Credential.self)
    }
}
