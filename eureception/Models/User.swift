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
    @NSManaged var removed: Bool
    
    var nameKatana: String {
        
        let value = self.nameEn.characters.split(" ").map { String($0) }.reverse().reduce(String()) { $0 + $1 }
        return value.stringByTransliteratingRomajiToKatakana()
    }
    
    var nameHiragana: String {
        
        let value = self.nameEn.characters.split(" ").map { String($0) }.reverse().reduce(String()) { $0 + $1 }
        return value.stringByTransliteratingRomajiToHiragana()
    }
    
    func compare(candidate: String) -> Bool {
        
        func excludeSpace(string: String) -> String {
            
            return string.stringByReplacingOccurrencesOfString(" ", withString: "")
        }
        
        if excludeSpace(nameEn).lowercaseString.hasPrefix(candidate.lowercaseString) ||
            excludeSpace(nameJa).hasPrefix(candidate) ||
            excludeSpace(nameKatana).hasPrefix(candidate) ||
            excludeSpace(nameHiragana).hasPrefix(candidate) {
                
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
