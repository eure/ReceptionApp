//
//  PurposeButton.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/30/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class PurposeButton: UIControl {
    
    var backgroundLayer = CAShapeLayer()
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.insertSublayer(self.backgroundLayer, atIndex: 0)
        self.backgroundLayer.lineWidth = 2
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.backgroundLayer.fillColor = UIColor.whiteColor().CGColor
        self.backgroundLayer.strokeColor = UIColor.eureLightGrayColor.CGColor
        self.titleLabel?.textColor = UIColor.eureColor
        self.titleLabel?.font = UIFont.eureBoldFont(size: 32)
        self.subtitleLabel?.textColor = UIColor.eureColor
        self.subtitleLabel?.font = UIFont.eureBoldFont(size: 18)
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        self.backgroundLayer.path = UIBezierPath(roundedRect: CGRectInset(self.bounds, 1, 1), cornerRadius: 8).CGPath
    }
    
    override var enabled: Bool {
        get {
            return super.enabled
        }
        set {
            
            super.enabled = newValue
            self.alpha = newValue ? 1 : 0.3
        }
    }
    
    override var highlighted: Bool {
        get {
            
            return super.highlighted
        }
        set {
            
            super.highlighted = newValue
            
            UIView.animateWithDuration(0.2, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                self.alpha = newValue ? 0.4 : 1
                
                }) { (finish) -> Void in
            }
        }
    }
}
