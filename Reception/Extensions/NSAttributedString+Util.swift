//
//  NSAttributedString+Util.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    class func eureExoDemiBoldAttributedString(string: String, color: UIColor, size: CGFloat) -> NSAttributedString {
       
        return NSAttributedString(
            string: string,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 8),
                NSFontAttributeName : UIFont.exoDemiBold(size: size),
                NSForegroundColorAttributeName : color,
            ]
        )
    }
}