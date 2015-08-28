//
//  InputTextField.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class InputTextField: UITextField {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.defaultTextAttributes = [
            NSKernAttributeName : NSNumber(integer: 6),
            NSFontAttributeName :  UIFont.eureFont(size: 55),
            NSForegroundColorAttributeName : UIColor.eureBlackTextColor,
        ]
    }
}