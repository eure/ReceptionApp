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

enum Dispatcher {
    
    struct Error: ErrorType {
        let message: String
        let debugMessage: String
        
        init(message: String, debugMessage: String? = nil) {
            self.message = message
            self.debugMessage = debugMessage ?? message
        }
    }
    
    static func getUser(response: (result: Result<JSON, Error>) -> Void) {
        
        self.dispatch(url: baseURL + "/users", method: .GET, parameters: ["api_key": APIKey], response: response)
    }
    
    static func sendVisitor(transaction transaction: AppointmentTransaction, response: (result: Result<JSON, Error>) -> Void) {
        
        guard let visitor = transaction.visitor else {
            
            response(result: .Failure(Error(message: "")))
            return
        }
        
        self.dispatch(
            url: baseURL + "/visitor",
            parameters: [
                "api_key": APIKey,
                "visitor_type" : "appointment",
                "user_id" : NSNumber(longLong: transaction.user.id),
                "visitor_name" : visitor.name,
                "visitor_person_count" : visitor.numberOfPersons,
                "visitor_company_name" : visitor.companyName,
                "visitor_floor" : visitor.floor
            ],
            response: response)
    }
    
    static func sendVisitor(transaction transaction: OtherTransaction, response: (result: Result<JSON, Error>) -> Void) {
        
        self.dispatch(
            url: baseURL + "/visitor",
            parameters: [
                "api_key": APIKey,
                "visitor_type" : "other",
                "visitor_purpose" : transaction.visitor!.purpose,
                "visitor_company_name" : transaction.visitor!.companyName,
                "visitor_floor" : transaction.visitor!.floor
            ],
            response: response)
    }
    
    private static let APIKey = "O4mug2zIiuNcfd0WKMYN0Nz4EnrPa5"
    private static let baseURL = "https://reception.eure.jp/api/v1"

    private static func dispatch(url url: String, method: Alamofire.Method = .POST, parameters: [String: AnyObject]?, response: (result: Result<JSON, Error>) -> Void) {
        
        let responseSerializer = ResponseSerializer { (request, response, data, error) -> Result<JSON, Error> in
            
            if let jsonData = data {
                let json = JSON(data: jsonData)
                JEDump(json, "response")
                return .Success(json)
            }
            return .Failure(Error(message: "Failed to dispatch"))
        }
        
        Manager.sharedInstance.request(
            method,
            url,
            parameters: parameters,
            encoding: ParameterEncoding.URL,
            headers: nil)
            .response(queue: nil, responseSerializer: responseSerializer) { _response in
                
                response(result: _response.result)
        }
        .resume()
    }
}
