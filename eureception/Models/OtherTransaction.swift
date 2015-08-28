//
//  OtherTransaction.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

struct OtherTransaction: Transaction {
    
    let visitor: OtherVisitor
    
    init(visitor: OtherVisitor){
        self.visitor = visitor
    }
}
