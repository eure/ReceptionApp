//
//  Visitor.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/18/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation

protocol Visitor {
    
    var companyName: String { get set }
}

struct AppointmentVisitor: Visitor {
    
    var name: String = ""
    var numberOfPersons: Int = 1
    var companyName: String = ""
    init() {

    }
}

struct OtherVisitor: Visitor {
    
    var purpose: String = ""
    var companyName: String = ""
    
    init() {
    }
}