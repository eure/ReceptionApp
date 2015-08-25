//
//  HorizontalLineView.swift
//  Reception
//
//  Created by Muukii on 8/10/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class HorizontalLineView: UIView {
    
    @IBInspectable var lineColor: UIColor {
        get {
            return UIColor(CGColor: self.underlineLayer.strokeColor ?? UIColor.clearColor().CGColor)
        }
        set {
            self.underlineLayer.strokeColor = newValue.CGColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(self.underlineLayer)
        self.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.addSublayer(self.underlineLayer)
        self.clipsToBounds = false
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        
        let lineWidth = (1.0 / UIScreen.mainScreen().scale) * 3
        let lineOffset = lineWidth / 2.0
        let y = self.layer.bounds.midY - lineOffset
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: y))
        path.addLineToPoint(CGPoint(x: self.layer.bounds.maxX, y: y))
        
        self.underlineLayer.path = path.CGPath
        self.underlineLayer.lineWidth = lineWidth
    }
    
    let underlineLayer = CAShapeLayer()
}