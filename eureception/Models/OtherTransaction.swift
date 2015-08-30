//
//  OtherTransaction.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

struct OtherTransaction: Transaction {
    
    var visitor: OtherVisitor?
    
    static func Delivery() -> OtherTransaction {
        
        var visitor = OtherVisitor()
        visitor.companyName = ""
        visitor.purpose = "ご用件 : 配達"
        
        var transaction = OtherTransaction()
        transaction.visitor = visitor
        
        return transaction
    }
}
