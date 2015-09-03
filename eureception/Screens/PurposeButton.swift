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
    
    var shape = CAShapeLayer()
    
    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.insertSublayer(self.shape, atIndex: 0)
        self.shape.lineWidth = 2
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.iconImageView?.tintColor = UIColor.eureColor
        self.iconImageView?.tintColor = UIColor.eureColor
        self.shape.fillColor = UIColor.whiteColor().CGColor
        self.shape.strokeColor = UIColor.eureLightGrayColor.CGColor
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        self.shape.path = UIBezierPath(roundedRect: CGRectInset(self.bounds, 1, 1), cornerRadius: 8).CGPath
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
            
            if newValue {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                    
                    self.alpha = 0.6
                    self.layer.transform = CATransform3DMakeScale(0.99, 0.99, 1)
                    self.shape.fillColor = UIColor(white: 0, alpha: 0.02).CGColor
                    }, completion: { (finish) -> Void in
                        
                })
            } else {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                    
                    self.alpha = 1
                    self.layer.transform = CATransform3DIdentity
                    self.shape.fillColor = UIColor.clearColor().CGColor
                    }, completion: { (finish) -> Void in
                        
                })
            }
        }
    }
}
