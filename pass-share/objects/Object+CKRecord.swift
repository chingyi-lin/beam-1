import Foundation
import CloudKit
import RealmSwift

extension Object {
    func createCKRecord() -> CKRecord {
        let mirror = Mirror(reflecting: self)
        let record = CKRecord(recordType: "\(type(of: self))")
        
        for child in mirror.children {
            if let key = child.label {
                if let value = child.value as? String {
                    record[key] = value
                }
            }
        }
        return record
    }
} 
