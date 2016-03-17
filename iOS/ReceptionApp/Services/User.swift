//
//  User.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2016 eureka, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

import CoreStore
import SwiftyJSON


// MARK: - User

@objc final class User: NSManagedObject, ImportableUniqueObject {
    
    
    // MARK: Internal
    
    @NSManaged dynamic var id: Int64
    @NSManaged dynamic var imageURL: String!
    @NSManaged dynamic var nameEn: String!
    @NSManaged dynamic var nameJa: String!
    @NSManaged dynamic var slackID: String!
    @NSManaged dynamic var slackName: String!
    @NSManaged dynamic var removed: Bool
    
    func matches(query: String) -> Bool {
        
        let strings = [
            self.nameEn.lowercaseString,
            self.nameJa,
            self.nameKatana,
            self.nameHiragana
        ].lazy
        return strings.contains {
            
            self.separateSpace($0).lazy.contains { $0.hasPrefix(query) }
        }
    }
    
    
    // MARK: ImportableUniqueObject 
    
    static var uniqueIDKeyPath: String {
        
        return "id"
    }
    
    var uniqueIDValue: NSNumber {
        
        get { return NSNumber(longLong: self.id) }
        set { self.id = newValue.longLongValue }
    }
    
    static func uniqueIDFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) throws -> NSNumber? {
        
        return source["id"].number
    }
    
    func updateFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) throws {
        
        self.id = source["id"].int64Value
        self.imageURL = source["face_image_url"].stringValue
        self.nameEn = source["name_en"].stringValue
        self.nameJa = source["name_ja"].stringValue
        self.slackID = source["slack_account_id"].stringValue
        self.slackName = source["slack_account_name"].stringValue
        self.removed = source["deleted"].boolValue        
    }
    
    static func shouldUpdateFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) -> Bool {
        
        return true
    }
    
    static func shouldInsertFromImportSource(source: JSON, inTransaction transaction: BaseDataTransaction) -> Bool {
        
        return true
    }
    
    
    // MARK: Private
    
    private lazy var nameKatana: String = self
        .separateSpace(self.nameEn)
        .joinWithSeparator(" ")
        .stringByTransliteratingRomajiToKatakana()
    
    private lazy var nameHiragana: String = self
        .separateSpace(self.nameEn)
        .joinWithSeparator(" ")
        .stringByTransliteratingRomajiToHiragana()
    
    private func separateSpace(string: String) -> [String] {
        
        return string.characters.split(" ").reverse().map(String.init)
    }
}
