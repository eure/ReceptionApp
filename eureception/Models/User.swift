//
//  User.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import CoreStore

@objc(User)
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
}
