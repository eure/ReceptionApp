//
//  TopButton.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class TopButton: UIControl {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.layer.addSublayer(self.shape)
        self.clipsToBounds = true
    }
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        
        let width = (1.0 / UIScreen.mainScreen().scale) * 5.0
        let path = UIBezierPath(roundedRect: CGRectInset(self.bounds, width / 2, width / 2), cornerRadius: 8)
        self.shape.path = path.CGPath
        self.shape.fillColor = UIColor.clearColor().CGColor
        self.shape.lineWidth = width
        self.shape.strokeColor = UIColor.eureLightGrayColor.CGColor
    }
    
    var title: String? {
        get {
            
            return self.titleLabel?.text
        }
        set {
            
            self.titleLabel?.text = newValue
        }
    }
    
    override var tintColor: UIColor? {
        get{
            return super.tintColor
        }
        set {
            
            super.tintColor = newValue
            self.titleLabel?.textColor = newValue
            self.subtitleLabel?.textColor = newValue
            self.imageView?.tintColor = newValue
            
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
    
    @IBOutlet dynamic var titleLabel: UILabel?
    @IBOutlet dynamic var subtitleLabel: UILabel?
    @IBOutlet private dynamic var imageView: UIImageView?
    
    private let shape = CAShapeLayer()
    @IBOutlet private dynamic var iconImageView: UIImageView?
}
