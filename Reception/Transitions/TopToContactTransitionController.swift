//
//  TopToContactTransitionController.swift
//  Reception
//
//  Created by Muukii on 8/26/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class TopToContactTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
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
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! ContactToViewController
            
            toVC.inputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
            toVC.tableView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
            toVC.backButton.alpha = 0
            
            let transform = CATransform3DMakeTranslation(-offset, 0, 0)
            UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                fromVC.buttonView.layer.transform = transform
                fromVC.welcomeLabel.layer.transform = transform
                fromVC.welcomeBottomLabel.layer.transform = transform
                
                }, completion: { (finish) -> Void in
                    
                    fromVC.buttonView.layer.transform = CATransform3DIdentity
                    fromVC.welcomeLabel.layer.transform = CATransform3DIdentity
                    fromVC.welcomeBottomLabel.layer.transform = CATransform3DIdentity
                    
                    containerView.addSubview(toVC.view)
            }).animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                toVC.inputFieldView.layer.transform = CATransform3DIdentity
                toVC.tableView.layer.transform = CATransform3DIdentity
                toVC.backButton.alpha = 1
                }, completion: { (finish) -> Void in
                    
                    transitionContext.completeTransition(true)
            })
            
            
        } else if operation == .Pop {
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ContactToViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! TopViewController
            
            containerView.insertSubview(toVC.view, atIndex: 0)
            
            let transform = CATransform3DMakeTranslation(-offset, 0, 0)
            toVC.buttonView.layer.transform = transform
            toVC.welcomeLabel.layer.transform = transform
            toVC.welcomeBottomLabel.layer.transform = transform
            
            UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                fromVC.tableView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
                fromVC.inputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
                fromVC.backButton.alpha = 0
                
                }, completion: { (finish) -> Void in
                    
                    fromVC.view.removeFromSuperview()
                    
            }).animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                toVC.buttonView.layer.transform = CATransform3DIdentity
                toVC.welcomeLabel.layer.transform = CATransform3DIdentity
                toVC.welcomeBottomLabel.layer.transform = CATransform3DIdentity
                }, completion: { (finish) -> Void in
                    
                    transitionContext.completeTransition(true)
            })
        }
    }
}