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
        
        let account = transaction.account
        guard let customer = transaction.customer else {
            return
        }
        
        let message: String = { return ""
            + "*\(customer.name)* is coming." + "\n"
            + "\n"
            + ">*Name*\n"
            + ">\(customer.name)\n"
            + ">\n"
            + ">*CompanyName*\n"
            + ">\(customer.companyName)\n"
            + ">\n"
            + ">*Mail Address*\n"
            + ">\(customer.mailAddress)\n"
            + ">\n"
            + "*---*"
            + "made in @muukii"
        }()
        
        Manager.sharedInstance.request(
            Alamofire.Method.POST,
            "https://slack.com/api/chat.postMessage",
            parameters: [
                "token": AppConfiguration.SlackToken,
                "channel": account.slackAccountId,
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
}