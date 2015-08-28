//
//  User.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import CoreStore
import SwiftyJSON

class User: NSManagedObject, ImportableUniqueObject {
    
    @NSManaged var id: Int64
    @NSManaged var imageURL: String!
    @NSManaged var nameEn: String!
    @NSManaged var nameJa: String!
    @NSManaged var slackID: String!
    @NSManaged var slackName: String!
    
    var nameKatana: String {
        
        return (self.nameEn as NSString).stringByTransliteratingRomajiToKatakana()
    }
    
    var nameHiragana: String {
        
        return (self.nameEn as NSString).stringByTransliteratingRomajiToHiragana()
    }
    
    func compare(candidate: String) -> Bool {
        
        if nameEn.lowercaseString.rangeOfString(candidate.lowercaseString) != nil ||
            nameJa.rangeOfString(candidate) != nil ||
            nameKatana.rangeOfString(candidate) != nil ||
            nameHiragana.rangeOfString(candidate) != nil {
                
                return true
        } else {
            return false
        }
        
    }
    
    // MARK: ImportableUniqueObject 
    
    static var uniqueIDKeyPath: String {
        return "id"
    }
    
    var uniqueIDValue: NSNumber {
        get { return NSNumber(longLong: self.id) }
        set { self.id = newValue.longLongValue }
    }
    
    static func uniqueIDFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) throws -> NSNumber? {
        
        return source["id"].number
    }
    
    func updateFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) throws {
        
        self.id = source["id"].int64Value
        self.imageURL = source["face_image_url"].stringValue
        self.nameEn = source["name_en"].stringValue
        self.nameJa = source["name_ja"].stringValue
        self.slackID = source["slack_account_id"].stringValue
        self.slackName = source["slack_account_name"].stringValue
        
        JEDump(self, "User")
    }
    
    static func shouldUpdateFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) -> Bool {
        return true
    }
    
    static func shouldInsertFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) -> Bool {
        return true
    }
    
    
}
