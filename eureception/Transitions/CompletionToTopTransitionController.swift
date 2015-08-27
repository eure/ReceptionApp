//
//  CompletionToStartingTransitionController.swift
//  Reception
//
//  Created by Muukii on 8/9/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class CompletionToTopTransitionController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.7
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        containerView.insertSubview(toVC.view, atIndex: 0)
        UIView.animateWithDuration(0.2, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            
            fromVC.view.alpha = 0
            
            }) { (finish) -> Void in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }
}
