//
//  VisitorsModel.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/28/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import SwiftyJSON

final class VisitorsModel: BaseModel {
    
    func sendVisitor(transaction transaction: AppointmentTransaction, completion: (result: ModelResult<JSON>) -> Void) {
       
        #if DEBUG
            #else
        Dispatcher.sendVisitor(transaction: transaction) { (result) -> Void in
            
        }
        #endif
    }
    
    func sendVisitor(transaction transaction: OtherTransaction, completion: (result: ModelResult<JSON>) -> Void) {
        
        #if DEBUG
            #else
        Dispatcher.sendVisitor(transaction: transaction) { (result) -> Void in
            
        }
        #endif
        
    }
}