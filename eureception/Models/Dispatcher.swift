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
        
        self.dispatch(url: baseURL + "/users", method: .GET, parameters: ["api_key": APIKey], response: response)
    }
    
    static func sendVisitor(transaction transaction: AppointmentTransaction, response: (result: Result<JSON>) -> Void) {
        
        guard let visitor = transaction.visitor else {
            
            response(result: .Failure(nil, DispatcherErrorType.SomethingError))
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
    
    static func sendVisitor(transaction transaction: OtherTransaction, response: (result: Result<JSON>) -> Void) {
        
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
    private static func dispatch(url url: String, method: Alamofire.Method = .POST, parameters: [String: AnyObject]?, response: (result: Result<JSON>) -> Void) {
        
        Manager.sharedInstance.request(
            method,
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
            if let jsonData = data {
                let json = JSON(data: jsonData)
                JEDump(json, "response")
                return .Success(json)
            }
            return .Failure(data, ReceptionResponseErrorType.SomethingError)
        }
    }
}