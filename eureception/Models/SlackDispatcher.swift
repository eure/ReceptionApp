//
//  Slack.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/18/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import Alamofire

struct SlackDispatcher {
    
    static func call(transaction: AppointTransaction) {
        
        let user = transaction.user
        guard let visitor = transaction.visitor else {
            return
        }
        
        let message: String = { return ""
            + "@\(user.slackName)\n"
            + "*エウレカ受付*" + "\n"
            + "\n"
            + ">*名前*\n"
            + ">\(visitor.name)\n"
            + ">*会社名*\n"
            + ">\(visitor.companyName)\n"
            + ">*人数*\n"
            + ">\(visitor.numberOfPersons)\n"
            + "*---*"
            + "made in @muukii"
        }()
        
        Manager.sharedInstance.request(
            Alamofire.Method.POST,
            "https://slack.com/api/chat.postMessage",
            parameters: [
                "token": AppConfiguration.SlackToken,
                "channel": user.slackID,
                "text": message,
                "parse": "full",
                "username": "eureka reception",
                "link_names": 1,
                "icon_url": "https://avatars0.githubusercontent.com/u/3447204?v=3&s=200"
            ],
            encoding: ParameterEncoding.URL,
            headers: nil
            )
            .response { (request, response, data, error) -> Void in
                JEDump(request)
                JEDump(response)
                JEDump(data)
            }
        
        Manager.sharedInstance.request(
            Alamofire.Method.POST,
            "https://slack.com/api/chat.postMessage",
            parameters: [
                "token": AppConfiguration.SlackToken,
                "channel": "C09DKDH62",
                "text": message,
                "parse": "full",
                "username": "eureka reception",
                "link_names": 1,
                "icon_url": "https://avatars0.githubusercontent.com/u/3447204?v=3&s=200"
            ],
            encoding: ParameterEncoding.URL,
            headers: nil
            )
            .response { (request, response, data, error) -> Void in
                JEDump(request)
                JEDump(response)
                JEDump(data)
        }
    }
    
    
    static func call(transaction: GeneralTransaction) {
        
        let message: String = { return ""
            + "エウレカ受付" + "\n"
            }()
        
        Manager.sharedInstance.request(
            Alamofire.Method.POST,
            "https://slack.com/api/chat.postMessage",
            parameters: [
                "token": AppConfiguration.SlackToken,
                "channel": "C09DK929Y",
                "text": message,
                "parse": "full",
                "username": "エウレカ受付",
                "link_names": 1,
                "icon_url": "https://avatars0.githubusercontent.com/u/3447204?v=3&s=200"
            ],
            encoding: ParameterEncoding.URL,
            headers: nil
            )
            .response { (request, response, data, error) -> Void in
                JEDump(request)
                JEDump(response)
                JEDump(data)
        }
    }
}