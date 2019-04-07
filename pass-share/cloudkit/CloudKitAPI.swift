import Foundation
import CloudKit

final class CloudKitAPI {
    static let shared = CloudKitAPI()
    
    let privateDatabase: CKDatabase;
    let sharedDatabase: CKDatabase;
    
    private init() {
        let container = CKContainer.default()
        privateDatabase = container.privateCloudDatabase
        sharedDatabase = container.sharedCloudDatabase
    }
    
    func sync(_ credential: Credential) {
        let credentialRecord = credential.createCKRecord()
       
        privateDatabase.save(credentialRecord) {
            (record, error) in
            if let error = error {
                // Insert error handling
                print("Failed to sync to iCloud: '\(error)'")
                return
            }
            print("Successfully sync to iCloud")
        }
    }
}
