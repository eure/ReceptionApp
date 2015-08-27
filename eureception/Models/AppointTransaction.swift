//
//  CallTransaction.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/18/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Parse

class AppointTransaction: Transaction {
    
    var visitor: Visitor?
    var user: User
    
    init(user: User) {
        
        self.user = user
    }
}