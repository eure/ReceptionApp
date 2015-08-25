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
            self.imageView?.tintColor = newValue
        }
    }
    
    @IBOutlet dynamic var titleLabel: UILabel?
    @IBOutlet private dynamic var imageView: UIImageView?
    
    private let shape = CAShapeLayer()
    @IBOutlet private dynamic var iconImageView: UIImageView?
}
