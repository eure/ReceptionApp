//
//  UsersModel.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreStore

class UsersModel: BaseModel {
    
    func getUsers(result: ((result: ModelResult<[User]>) -> Void)) {
        
        Manager.sharedInstance.request(
            Alamofire.Method.POST,
            "https://slack.com/api/chat.postMessage",
            parameters: [ : ],
            encoding: ParameterEncoding.URL,
            headers: nil
            )
        .response(queue: nil, responseSerializer: ReceptionResponseSerializer()) { (request, response, _result) -> Void in
            
            switch _result {
            case .Success(let json):
                
                result(result: .Success([]))
            case .Failure(let data, let errorType):
                
                result(result: .Failure(.SomethingError))
            }
        }
    }
}