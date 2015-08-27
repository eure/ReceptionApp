//
//  User.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import CoreStore

class User: NSManagedObject {
    
    @NSManaged var imageURL: String!
    @NSManaged var nameEn: String!
    @NSManaged var nameJa: String!
    @NSManaged var slackID: String!
    @NSManaged var slackName: String!
}
