//
//  UIColor+Util.swift
//  Reception
//
//  Created by Muukii on 8/8/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    struct Cache {
        
        static let eureColor = UIColor(hexString: "C8CC52")!
        static let eurekaBackgroundColor = UIColor(white: 0.18, alpha: 1)
        static let eurekaLightBackgroundColor = UIColor(red: 0.325, green: 0.341, blue: 0.353, alpha: 1)
        static let errorTextColor = UIColor(red: 0.98, green: 0.278,blue: 0.349,alpha: 1)
        static let eureBlackTextColor = UIColor(white: 0, alpha: 0.9)
        static let eureLightGrayTextColor = UIColor(hexString: "#E6E6E6")!
        static let eureLightGrayColor = UIColor(hexString: "f5f5f5")!
    }
    
    class var eureColor: UIColor {
        
        return Cache.eureColor
    }
    
    class var eurekaBackgroundColor: UIColor {
        
        return Cache.eurekaBackgroundColor
    }
    
    class var eurekaLightBackgroundColor: UIColor {
        
        return Cache.eurekaLightBackgroundColor
    }
    
    class var errorTextColor: UIColor {
        
        return Cache.errorTextColor
    }
    
    class var eureLightGrayTextColor: UIColor {
        
        return Cache.eureLightGrayTextColor
    }
    
    class var eureLightGrayColor: UIColor {
        
        return Cache.eureLightGrayColor
    }
    
    class var eureBlackTextColor: UIColor {
        
        return Cache.eureBlackTextColor
    }

}