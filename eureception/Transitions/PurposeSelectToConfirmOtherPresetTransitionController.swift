//
//  PurposeSelectToConfirmOtherPresetTransitionController.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/30/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation

class PurposeSelectToConfirmOtherPresetTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
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
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! OtherPurposeSelectViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ConfirmOtherPresetViewController
            
            let submitButton = toVC.submitButton
            let messageJaLabel = toVC.messageJaLabel
            let messageEnLabel = toVC.messageEnLabel                        
            
            submitButton.alpha = 0
            messageJaLabel.alpha = 0
            messageEnLabel.alpha = 0
            
            UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                fromVC.selectView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
                
                }, completion: { (finish) -> Void in
                    
                    containerView.addSubview(toVC.view)
                    
                    UIView.animateWithDuration(0.3, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        messageJaLabel.alpha = 1
                        messageEnLabel.alpha = 1
                        submitButton.alpha = 1
                        
                        }, completion: { (finish) -> Void in
                            
                            transitionContext.completeTransition(true)                            
                    })
            })
            
        } else if operation == .Pop {
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ConfirmOtherPresetViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! OtherPurposeSelectViewController
            
            let submitButton = fromVC.submitButton
            let messageJaLabel = fromVC.messageJaLabel
            let messageEnLabel = fromVC.messageEnLabel
            
            toVC.selectView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
            
            containerView.insertSubview(toVC.view, atIndex: 0)
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                submitButton.alpha = 0
                messageJaLabel.alpha = 0
                messageEnLabel.alpha = 0
                }, completion: { (finish) -> Void in
                    
                    fromVC.view.removeFromSuperview()
                    
                    UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        toVC.selectView.layer.transform = CATransform3DIdentity
                        
                        }, completion: { (finish) -> Void in
                            transitionContext.completeTransition(true)
                    })
                    
            })
            
        }
    }
}