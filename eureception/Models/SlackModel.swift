//
//  SlackModel.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/28/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import SwiftyJSON

final class SlackModel: BaseModel {
    
    func callSlack(transaction transaction: AppointmentTransaction, completion: (result: ModelResult<JSON>) -> Void) {
        
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
        
        Dispatcher.callSlack(message: message, channel: user.slackID) { (result) -> Void in
            
        }

        Dispatcher.callSlack(message: message, channel: "C09DK929Y") { (result) -> Void in
            
        }
        
    }
    
    func callSlack(transaction transaction: OtherTransaction, completion: (result: ModelResult<JSON>) -> Void) {
        
        let message: String = { return ""
            + "エウレカ受付" + "\n"
            }()
        
        Dispatcher.callSlack(message: message, channel: "C09DK929Y") { (result) -> Void in
            
        }
    }
    
}