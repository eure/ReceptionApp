//
//  TopButton.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/23/15.
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


// MARK: - TopButton

final class TopButton: UIControl {
    
    
    // MARK: Internal
    
    @IBOutlet dynamic var titleLabel: UILabel?
    @IBOutlet dynamic var subtitleLabel: UILabel?
    
    var title: String? {
        
        get { return self.titleLabel?.text }
        set { self.titleLabel?.text = newValue }
    }
    
    
    // MARK: NSObject
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.backgroundColor = Configuration.Color.largeButtonBackgroundColor
        self.tintColor = Configuration.Color.largeButtonTintColor
        self.layer.addSublayer(self.shape)
        self.clipsToBounds = true
    }
    
    
    // MARK: UIView
    
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
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        
        super.layoutSublayersOfLayer(layer)
        
        let width = (1.0 / UIScreen.mainScreen().scale) * 3.0
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
                animations: {
                    
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
    
    @IBOutlet private dynamic var imageView: UIImageView?
    @IBOutlet private dynamic var iconImageView: UIImageView?
    
    private let shape = CAShapeLayer()
}
