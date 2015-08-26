//
//  Customer.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/18/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation

struct Customer {
    
    var name: String
    var numberOfPersons: Int = 1
    var companyName: String = ""
    var mailAddress: String = ""

    init(name: String) {
        self.name = name
    }
    
    init(name: String, numberOfPersons: Int, companyName: String?, mailAddress: String?) {
        
        self.name = name
        self.companyName = companyName ?? ""
        self.numberOfPersons = numberOfPersons
        self.mailAddress = mailAddress ?? ""
    }
}