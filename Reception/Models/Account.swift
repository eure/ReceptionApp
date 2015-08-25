//
//  Employee.swift
//  Reception
//
//  Created by Muukii on 8/8/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation

struct Account {
    
    let nameJa: String
    let nameEn: String
    let slackAccountName: String
    let slackAccountId: String
    let phoneNumber: String
    let faceImage: UIImage
    
    var nameKatana: String {
        
        return (self.nameEn as NSString).stringByTransliteratingRomajiToKatakana()
    }
    
    var nameHiragana: String {
        
        return (self.nameEn as NSString).stringByTransliteratingRomajiToHiragana()
    }
    
    init(
        nameJa: String,
        nameEn: String,
        slackAccountName: String,
        slackAccountId: String,
        phoneNumber: String,
        faceImage: UIImage = UIImage()) {
        
            self.nameJa = nameJa
            self.nameEn = nameEn
            self.slackAccountName = slackAccountName
            self.slackAccountId = slackAccountId
            self.phoneNumber = phoneNumber
            self.faceImage = faceImage
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

extension Account {
    
    static func allEmployees() -> [Account] {
        
        return [
            Account(
                nameJa: "木村 寛",
                nameEn: "Hiroshi Kimura",
                slackAccountName: "muukii",
                slackAccountId: "U02HJDR1D",
                phoneNumber: "080-4606-6418"
            ),
        ]
    }
}