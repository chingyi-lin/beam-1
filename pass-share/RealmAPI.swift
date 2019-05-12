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
    
    func delete(data: Object) {
        try! realm.write {
            realm.delete(data)
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
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
    
    func updateCredentialPassword(for data: Credential, with password: String) {
        try! realm.write {
            data.setPassword(password)
        }
    }
    
    func updateProfileSyncOption(for data: Profile, with cloudSync: Bool) {
        try! realm.write {
            data.cloudSync = cloudSync
        }
    }
    
    func updateProfileNameAndEmail(for data: Profile, with name: String, with email: String) {
        try! realm.write {
            data.name = name
            data.email = email
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
    
    func readShareInvitation(filterBy shareInvitationID: String) -> ShareInvitation {
        return realm.objects(ShareInvitation.self).filter("shareInvitationID = '\(shareInvitationID)'").first!
    }
    
    func readContactByEmail(filterBy contactEmail: String) -> Contact {
        return realm.objects(Contact.self).filter("email = '\(contactEmail)'").first!
    }
    
    func readCurrentProfile() -> Profile {
        return realm.objects(Profile.self).first!
    }
    
    func readAllActivity() -> Results<Activity> {
        return realm.objects(Activity.self)
    }
    
    func readAllShareInvitation() -> Results<ShareInvitation> {
        return realm.objects(ShareInvitation.self)
    }
    
    func readAll() -> Results<Credential> {
        return realm.objects(Credential.self)
    }
}
