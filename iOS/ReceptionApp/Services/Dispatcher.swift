//
//  Dispatcher.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/28/15.
//  Copyright © 2016 eureka, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

import Alamofire
import JEToolkit
import SwiftyJSON


// MARK: - Dispatcher

enum Dispatcher {
    
    // MARK: - Error
    
    struct Error: ErrorType {
        
        
        // MARK: Internal
        
        let message: String
        let debugMessage: String
        
        init(message: String, debugMessage: String? = nil) {
            
            self.message = message
            self.debugMessage = debugMessage ?? message
        }
    }
    
    
    // MARK: Internal
    
    static func getUser(response: (result: Result<JSON, Error>) -> Void) {
        
        self.dispatch(
            url: baseURL + "/users",
            method: .GET,
            parameters: ["api_key": APIKey],
            response: response
        )
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
            response: response
        )
    }
    
    static func sendVisitor(transaction transaction: OtherTransaction, response: (result: Result<JSON, Error>) -> Void) {
        
        let visitor = transaction.visitor!
        self.dispatch(
            url: baseURL + "/visitor",
            parameters: [
                "api_key": APIKey,
                "visitor_type" : "other",
                "visitor_purpose" : visitor.purpose,
                "visitor_company_name" : visitor.companyName,
                "visitor_floor" : visitor.floor
            ],
            response: response
        )
    }
    
    private static let APIKey = Configuration.Token.APIKey
    private static let baseURL = Configuration.Token.baseUrl

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
            encoding: .URL,
            headers: nil
        )
            .response(queue: nil, responseSerializer: responseSerializer) {
                
                response(result: $0.result)
            }
            .resume()
    }
}
