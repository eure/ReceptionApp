//
//  NextButton.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/24/15.
//  Copyright © 2016 eureka, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import UIKit


// MARK: - NextButton

final class NextButton: UIControl {
    
    
    // MARK: Internal

    @IBOutlet var nextImageView: UIImageView?
    
    
    // MARK: NSObject
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.insertSublayer(self.backgroundLayer, atIndex: 0)
        self.backgroundLayer.lineWidth = 2
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.backgroundLayer.fillColor = UIColor.clearColor().CGColor
        self.backgroundLayer.strokeColor = Configuration.Color.smallButtonBorderColor.CGColor
        self.nextImageView?.tintColor = Configuration.Color.smallButtonTintColor
    }
    
    
    // MARK: UIView
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        self.backgroundLayer.path = UIBezierPath(ovalInRect: self.bounds).CGPath
    }
    
    
    // MARK: UIControl
    
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
            
            UIView.animateWithDuration(
                0.2,
                delay: 0,
                options: .BeginFromCurrentState,
                animations: { () -> Void in
                
                    if newValue {
                        
                        self.backgroundLayer.fillColor = Configuration.Color.smallButtonTintColor.CGColor
                        self.backgroundLayer.strokeColor = Configuration.Color.smallButtonBorderColor.CGColor
                        self.nextImageView?.tintColor = Configuration.Color.backgroundColor
                    }
                    else {
                        
                        self.backgroundLayer.fillColor = UIColor.clearColor().CGColor
                        self.backgroundLayer.strokeColor = Configuration.Color.smallButtonBorderColor.CGColor
                        self.nextImageView?.tintColor = Configuration.Color.smallButtonTintColor
                    }
                },
                completion: { _ in }
            )
        }
    }
    
    
    // MARK: Private
    
    private let backgroundLayer = CAShapeLayer()
}
