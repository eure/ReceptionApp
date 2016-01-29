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
        
        if let string = _nameKatakana {
            return string
        }
        
        let value = self.separateSpace(self.nameEn).reduce(String()) { $0 + " " + $1 }
        _nameKatakana = value.stringByTransliteratingRomajiToKatakana()
        return _nameKatakana!
    }
    var _nameKatakana: String?
    
    var nameHiragana: String {
        
        if let string = _nameHiragana {
            return string
        }
        let value = self.separateSpace(self.nameEn).reduce(String()) { $0 + " " + $1 }
        _nameHiragana = value.stringByTransliteratingRomajiToHiragana()
        return _nameHiragana!
    }
    
    var _nameHiragana: String?
    
    func separateSpace(string: String) -> [String] {
        
        let results = string.characters.split(" ").reverse().map { String($0) }
        return results
    }
    
    func compare(candidate: String) -> Bool {
                      
        let _nameEn = separateSpace(self.nameEn.lowercaseString)
        let _nameJa = separateSpace(self.nameJa)
        let _nameKatakana = separateSpace(self.nameKatana)
        let _nameHiragana = separateSpace(self.nameHiragana)
        
        for _candidate in (_nameEn + _nameJa + _nameKatakana + _nameHiragana) {
            
            if _candidate.hasPrefix(candidate) {
                return true
            }
        }
        
        return false
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
        self.removed = source["deleted"].boolValue        
    }
    
    static func shouldUpdateFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) -> Bool {
        return true
    }
    
    static func shouldInsertFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) -> Bool {
        return true
    }
    
    
}
