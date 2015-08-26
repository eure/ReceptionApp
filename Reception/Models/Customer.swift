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

    init(name: String) {
        self.name = name
    }    
}