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

final class UsersModel {
    
    func getUsers(completion: ((result: ModelResult<[User]>) -> Void)) {
        
        Dispatcher.getUser { (result) -> Void in
            switch result {
            case .Success(let json):
                
                JEDump(json, "UsersModel.user")
                JEDump(json["users"].arrayValue, "UsersModel.user")
                
                CoreStore.beginAsynchronous { transaction in
                    
                    _ = try? transaction.importUniqueObjects(
                        Into(User),
                        sourceArray: json["users"].arrayValue
                    )
                    
                    transaction.commit { result in
                        
                        JEDump(json)
                        completion(result: .Success([]))
                    }
                }
            case .Failure(let errorType):
                
                completion(result: .Failure(.SomethingError))
            }
        }
    }
}