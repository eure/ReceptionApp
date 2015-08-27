//
//  NSAttributedString+Util.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    class func eureBoldAttributedString(string: String, color: UIColor, size: CGFloat) -> NSAttributedString {
       
        return NSAttributedString(
            string: string,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 2),
                NSFontAttributeName : UIFont.eureBoldFont(size: size),
                NSForegroundColorAttributeName : color,
            ]
        )
    }
    
    class func eureAttributedString(string: String, color: UIColor, size: CGFloat) -> NSAttributedString {
        
        return NSAttributedString(
            string: string,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 2),
                NSFontAttributeName : UIFont.eureFont(size: size),
                NSForegroundColorAttributeName : color,
            ]
        )
    }
}