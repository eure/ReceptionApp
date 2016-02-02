//
//  AppConfiguration.swift
//  eureception
//
//  Created by Hiroshi Kimura on 2/2/16.
//  Copyright © 2016 eureka. All rights reserved.
//

import Foundation

final class AppConfiguration {
    
    let baseURL: NSURL
    
    init(baseURL: NSURL) {
        
        self.baseURL = baseURL
    }
}