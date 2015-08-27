//
//  UIFont+Util.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation

extension UIFont {
    
    class func exoDemiBold(size size: CGFloat) -> UIFont {
        
        return UIFont(name: "Exo-DemiBold", size: size)!
    }
    
    class func eureFont(size size: CGFloat) -> UIFont {
        
        let descriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptorNameAttribute: "Exo-DemiBold",
            UIFontDescriptorCascadeListAttribute : [
                UIFontDescriptor(fontAttributes: [UIFontDescriptorNameAttribute: "KozGoPro-Medium"]),
                UIFont.systemFontOfSize(size).fontDescriptor()
            ]
            ]
        )
        
        return UIFont(descriptor: descriptor, size: size)
    }
}