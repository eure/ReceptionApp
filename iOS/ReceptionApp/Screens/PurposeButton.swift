//
//  PurposeButton.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/30/15.
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


// MARK: - PurposeButton

final class PurposeButton: UIControl {
    
    
    // MARK: Internal
    
    @IBOutlet private(set) dynamic weak var titleLabel: UILabel?
    @IBOutlet private(set) dynamic weak var subtitleLabel: UILabel?
    
    private var shape = CAShapeLayer()
    
    
    // MARK: NSObject
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.insertSublayer(self.shape, atIndex: 0)
        self.shape.lineWidth = 2
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        self.tintColor = Configuration.Color.largeButtonTintColor
        self.iconImageView?.tintColor = Configuration.Color.imageTintColor
    }
    
    
    // MARK: UIView
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        
        let width = (1.0 / UIScreen.mainScreen().scale) * 2.0
        let path = UIBezierPath(
            roundedRect: self.bounds.insetBy(dx: width / 2, dy: width / 2),
            cornerRadius: self.bounds.height / 2
        )
        self.shape.path = path.CGPath
        self.shape.fillColor = UIColor.clearColor().CGColor
        self.shape.lineWidth = width
        self.shape.strokeColor = Configuration.Color.largeButtonBorderColor.CGColor
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
                0.3,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0,
                options: .BeginFromCurrentState,
                animations: { () -> Void in
                
                    if newValue {
                        
                        self.alpha = 0.6
                        self.layer.transform = CATransform3DMakeScale(0.99, 0.99, 1)
                        self.shape.fillColor = UIColor(white: 0, alpha: 0.02).CGColor
                    }
                    else {
                        
                        self.alpha = 1
                        self.layer.transform = CATransform3DIdentity
                        self.shape.fillColor = UIColor.clearColor().CGColor
                    }
                },
                completion: { _ in }
            )
        }
    }
    
    
    // MARK: Private
    
    @IBOutlet private dynamic weak var iconImageView: UIImageView?
}
