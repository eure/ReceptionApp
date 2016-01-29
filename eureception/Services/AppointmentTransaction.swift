//
//  CallTransaction.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/18/15.
//  Copyright © 2015 eureka. All rights reserved.
//

class AppointmentTransaction: Transaction {
    
    var visitor: AppointmentVisitor?
    var user: User
    
    init(user: User) {
        
        self.user = user
    }
}