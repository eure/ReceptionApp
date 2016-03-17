//
//  ConfirmToCompletionTransitionController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/27/15.
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


// MARK: - ConfirmToCompletionTransitionController

final class ConfirmToCompletionTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    // MARK: UIViewControllerAnimatedTransitioning
    
    @objc dynamic func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.7
    }
    
    @objc dynamic func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! BaseConfirmViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! CompletionViewController
        let containerView = transitionContext.containerView()!
        
        containerView.addSubview(toVC.view)
        
        let baseLayer = fromVC.submitButton.layer
        let maskLayer = CALayer()
        maskLayer.frame = baseLayer.frame
        maskLayer.backgroundColor = UIColor.whiteColor().CGColor
        maskLayer.cornerRadius = maskLayer.frame.width / 2
        maskLayer.masksToBounds = true
        
        toVC.view.layer.mask = maskLayer
                
        toVC.iconImageView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1)
        toVC.titleLabel.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        toVC.subtitleLabel.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        toVC.iconImageView.alpha = 0
        toVC.titleLabel.alpha = 0
        toVC.subtitleLabel.alpha = 0
        
        UIView.animateAndChainWithDuration(
            0.3,
            delay: 0,
            options: .CurveEaseOut,
            animations: {
            
                maskLayer.transform = CATransform3DMakeScale(13, 13, 1)
            },
            completion: { _ in
                
                toVC.view.layer.mask = nil
            }
        ).animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0,
            options: [],
            animations: {
            
                toVC.iconImageView.layer.transform = CATransform3DIdentity
                toVC.titleLabel.layer.transform = CATransform3DIdentity
                toVC.subtitleLabel.layer.transform = CATransform3DIdentity
                toVC.iconImageView.alpha = 1
                toVC.titleLabel.alpha = 1
                toVC.subtitleLabel.alpha = 1
            },
            completion: { _ in
                
                transitionContext.completeTransition(true)
            }
        )
    }
}
