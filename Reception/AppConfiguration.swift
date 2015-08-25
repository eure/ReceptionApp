//
//  AppConfiguration.swift
//  Reception
//
//  Created by Muukii on 8/8/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation

struct AppConfiguration {
    
    static let allEmployees: [Account] = {
        
        return [
            Account(
                nameJa: "木村 寛",
                nameEn: "Hiroshi Kimura",
                slackAccountName: "muukii",
                slackAccountId: "U02HJDR1D",
                phoneNumber: "080-4606-6418"
            ),
            Account(
                nameJa: "ジョン エストロピア",
                nameEn: "John Estropia",
                slackAccountName: "johnestropia",
                slackAccountId: "U02TD2K92",
                phoneNumber: ""
            ),
            Account(
                nameJa: "金子 慎太郎",
                nameEn: "Shintaro Kaneko",
                slackAccountName: "kaneshin",
                slackAccountId: "U02HJCJDR",
                phoneNumber: ""
            ),
            Account(
                nameJa: "石橋 準也",
                nameEn: "Junya Ishibashi",
                slackAccountName: "junya",
                slackAccountId: "U02HJQQRU",
                phoneNumber: ""
            ),
            Account(
                nameJa: "亀谷 長翔",
                nameEn: "Sho Kameya",
                slackAccountName: "shokameya",
                slackAccountId: "U02HQLWUZ",
                phoneNumber: ""
            ),
            Account(
                nameJa: "川下 武",
                nameEn: "Takeru Kawashita",
                slackAccountName: "michael",
                slackAccountId: "U02HKBEQG",
                phoneNumber: ""
            ),
            Account(
                nameJa: "青山 遼",
                nameEn: "Ryo Aoyama",
                slackAccountName: "ryoaoyama",
                slackAccountId: "U02HJEFE9",
                phoneNumber: ""
            ),
        ]
    }()
    
    static let SlackToken = "xoxp-2361292637-2596467047-3237542349-75bb04"
    
    struct ParseKey {
        static let ApplicationKey = "jsVeElVRDLsd5JuHlEsJqwvNKZUVGyPmSsQjQoc1"
        static let ClientKey = "vieJWWPx4zIlhypGlQMQCOTBKqhpZJpN5CDxoujo"
    }
    
    struct TwillioKey {
        #if DEBUG
        static let AccountSID = "AC9f9cd058156c98e7964032a5731c19a5"
        static let AuthToken = "9c7f740b74b997640f8be09a1f3bc294"
        #else
        static let AccountSID = "AC79520662725f8a81a422cba94018ee1a"
        static let AuthToken = "6d6fcae6b5a0e77d031227ba154c32ad"
        #endif
    }
}