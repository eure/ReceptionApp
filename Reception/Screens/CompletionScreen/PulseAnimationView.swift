//
//  PulseAnimationView.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/19/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class PulseAnimationView: UIView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let r = CAReplicatorLayer()
        r.frame = self.bounds
        r.instanceCount = 6
        r.instanceDelay = 2
        self.layer.addSublayer(r)
        
        let pulseLayer = CALayer()
        pulseLayer.bounds = self.bounds
        pulseLayer.backgroundColor = UIColor(white: 1, alpha: 0.15).CGColor
        pulseLayer.cornerRadius = self.bounds.height/2
        pulseLayer.masksToBounds = true
        r.addSublayer(pulseLayer)
        pulseLayer.transform = CATransform3DMakeScale(0.2, 0.2, 1)
        pulseLayer.position = r.position
        pulseLayer.opacity = 1
        
        UIView.animateWithDuration(6, delay: 0, options: [.Repeat, .CurveEaseOut], animations: { () -> Void in
            
            pulseLayer.transform = CATransform3DIdentity
            pulseLayer.opacity = 0
            }) { (finish) -> Void in
                
        }
    }
    
}