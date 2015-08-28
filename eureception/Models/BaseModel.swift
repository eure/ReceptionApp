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

enum ModelErrorType: ErrorType {
    case SomethingError
}

enum ModelResult<T> {
    case Success(T)
    case Failure(ModelErrorType)
}

class BaseModel {
    
}
