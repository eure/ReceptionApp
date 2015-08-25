//
//  ContactButton.swift
//  Reception
//
//  Created by Muukii on 8/10/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class ContactButton: UIControl {
    
    @IBOutlet var checkImageView: UIImageView?
    var backgroundLayer = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.insertSublayer(self.backgroundLayer, atIndex: 0)
        self.backgroundLayer.lineWidth = 2
        self.highlighted = false
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.checkImageView?.tintColor = UIColor.eureColor
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        self.backgroundLayer.path = UIBezierPath(ovalInRect: self.bounds).CGPath
    }
    
    override var highlighted: Bool {
        get {
            
            return super.highlighted
        }
        set {
           
            super.highlighted = newValue
            
            if newValue {
                self.backgroundLayer.fillColor = UIColor.eureColor.CGColor
                self.backgroundLayer.strokeColor = UIColor.eureColor.CGColor
                self.checkImageView?.tintColor = UIColor.whiteColor()
            } else {
                self.backgroundLayer.fillColor = UIColor.whiteColor().CGColor
                self.backgroundLayer.strokeColor = UIColor.eureColor.CGColor
                self.checkImageView?.tintColor = UIColor.eureColor
            }
        }
    }
}