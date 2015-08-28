//
//  Dispatcher.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/28/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum DispatcherErrorType: ErrorType {
    case SomethingError
}

enum Dispatcher {
    
    static func getUser(response: (result: Result<JSON>) -> Void) {
        
        self.dispatch(url: baseURL + "/users", parameters: nil, response: response)
    }
    
    static func sendVisitor(transaction transaction: AppointmentTransaction, response: (result: Result<JSON>) -> Void) {
        
        guard let visitor = transaction.visitor else {
            
            response(result: .Failure(nil, DispatcherErrorType.SomethingError))
            return
        }
        
        self.dispatch(
            url: baseURL + "/visitor",
            parameters: [
                "visitor_type" : "appointment",
                "user_id" : NSNumber(longLong: transaction.user.id),
                "visitor_name" : visitor.name,
                "visitor_count" : visitor.numberOfPersons,
                "visitor_company_name" : visitor.companyName
            ],
            response: response)
    }
    
    static func sendVisitor(transaction transaction: OtherTransaction, response: (result: Result<JSON>) -> Void) {
        
        self.dispatch(
            url: baseURL + "/visitor",
            parameters: [
                "visitor_type" : "other",
                "visitor_purpose" : transaction.visitor.purpose
            ],
            response: response)
    }
    
    static func callSlack(message message: String, channel: String, response: (result: Result<JSON>) -> Void) {
        
        self.dispatch(
            url: "https://slack.com/api/chat.postMessage",
            parameters: [
                "token": AppConfiguration.SlackToken,
                "channel": channel,
                "text": message,
                "parse": "full",
                "username": "エウレカ受付",
                "link_names": 1,
                "icon_url": "https://avatars0.githubusercontent.com/u/3447204?v=3&s=200"
            ],
            response: response)
    }
        
    private static let baseURL = "https://reception.eure.jp/api/v1"
    private static func dispatch(url url: String, parameters: [String: AnyObject]?, response: (result: Result<JSON>) -> Void) {
        
        Manager.sharedInstance.request(
            Alamofire.Method.POST,
            url,
            parameters: parameters,
            encoding: ParameterEncoding.URL,
            headers: nil
            )
            .response(queue: nil, responseSerializer: ReceptionResponseSerializer()) { (_request, _response, _result) -> Void in
                
                response(result: _result)
        }
    }
}

enum ReceptionResponseErrorType: ErrorType {
    case SomethingError
}
struct ReceptionResponseSerializer: ResponseSerializer {
    
    var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?) -> Result<JSON> {
        
        return { request, response, data in
            JEDump(response, "response")
            JEDump(data, "data")
            if let jsonData = data {
                let json = JSON(jsonData)
                JEDump(json, "response")
                return .Success(json)
            }
            return .Failure(data, ReceptionResponseErrorType.SomethingError)
        }
    }
}