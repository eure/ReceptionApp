//
//  TopToOtherPurposeTransitionController.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation


class TopToOtherPurposeTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationControllerOperation = .None
    convenience init(operation: UINavigationControllerOperation) {
        
        self.init()
        self.operation = operation
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        
        let offset = UIScreen.mainScreen().bounds.width
        
        if operation == .Push {
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! TopViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! OtherPurposeViewController
            
            toVC.inputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
            toVC.backButton.alpha = 0
            
            let transform = CATransform3DMakeTranslation(-offset, 0, 0)
            UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                fromVC.appointButton.layer.transform = transform
                fromVC.otherButton.layer.transform = transform
                fromVC.welcomeLabel.layer.transform = transform
                fromVC.welcomeBottomLabel.layer.transform = transform
                
                }, completion: { (finish) -> Void in
                    
                    fromVC.appointButton.layer.transform = CATransform3DIdentity
                    fromVC.otherButton.layer.transform = CATransform3DIdentity
                    fromVC.welcomeLabel.layer.transform = CATransform3DIdentity
                    fromVC.welcomeBottomLabel.layer.transform = CATransform3DIdentity
                    
                    containerView.addSubview(toVC.view)
            }).animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                toVC.inputFieldView.layer.transform = CATransform3DIdentity
                toVC.backButton.alpha = 1
                }, completion: { (finish) -> Void in
                    
                    transitionContext.completeTransition(true)
            })
            
            
        } else if operation == .Pop {
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! OtherPurposeViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! TopViewController
            
            containerView.insertSubview(toVC.view, atIndex: 0)
            
            let transform = CATransform3DMakeTranslation(-offset, 0, 0)
            toVC.appointButton.layer.transform = transform
            toVC.otherButton.layer.transform = transform
            toVC.welcomeLabel.layer.transform = transform
            toVC.welcomeBottomLabel.layer.transform = transform
            
            UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                fromVC.inputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
                fromVC.backButton.alpha = 0
                
                }, completion: { (finish) -> Void in
                    
                    fromVC.view.removeFromSuperview()
                    
            }).animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                toVC.appointButton.layer.transform = CATransform3DIdentity
                toVC.otherButton.layer.transform = CATransform3DIdentity
                toVC.welcomeLabel.layer.transform = CATransform3DIdentity
                toVC.welcomeBottomLabel.layer.transform = CATransform3DIdentity
                }, completion: { (finish) -> Void in
                    
                    transitionContext.completeTransition(true)
            })
        }
    }
}
