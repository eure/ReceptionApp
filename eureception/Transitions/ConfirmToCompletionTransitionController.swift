//
//  ConfirmToCompletionTransitionController.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class ConfirmToCompletionTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.7
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! BaseConfirmViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! CompletionViewController
        let containerView = transitionContext.containerView()!
        
        containerView.addSubview(toVC.view)
        
        let baseLayer = fromVC.submitButton.layer
        let maskLayer = CALayer()
        maskLayer.frame = baseLayer.frame
        maskLayer.backgroundColor = UIColor.eureBlackTextColor.CGColor
        maskLayer.cornerRadius = maskLayer.frame.width / 2
        maskLayer.masksToBounds = true
        
        toVC.view.layer.mask = maskLayer
                
        toVC.iconImageView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1)
        toVC.titleLabel.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        toVC.subtitleLabel.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        toVC.iconImageView.alpha = 0
        toVC.titleLabel.alpha = 0
        toVC.subtitleLabel.alpha = 0
        
        UIView.animateAndChainWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            
            maskLayer.transform = CATransform3DMakeScale(13, 13, 1)
            }) { (finish) -> Void in
                toVC.view.layer.mask = nil
        }.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            
                toVC.iconImageView.layer.transform = CATransform3DIdentity
                toVC.titleLabel.layer.transform = CATransform3DIdentity
                toVC.subtitleLabel.layer.transform = CATransform3DIdentity
                toVC.iconImageView.alpha = 1
                toVC.titleLabel.alpha = 1
                toVC.subtitleLabel.alpha = 1
            }) { (finish) -> Void in
                
                    transitionContext.completeTransition(true)
        }
        
    }
}