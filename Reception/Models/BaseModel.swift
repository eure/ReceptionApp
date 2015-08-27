//
//  BaseModel.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreStore

enum ModelResult<T> {
    case Success(T)
    case Failure(NSError)
}

class BaseModel {
    
}

enum ReceptionResponseErrorType: ErrorType {
    case SomethingError
}
struct ReceptionResponseSerializer: ResponseSerializer {
    
    var serializeResponse: (NSURLRequest?, NSHTTPURLResponse?, NSData?) -> Result<JSON> {
        
        return { request, response, data in
            if let jsonData = data {
                return .Success(JSON(jsonData))
            }
            return .Failure(data, ReceptionResponseErrorType.SomethingError)
        }
    }
}