//
//  ContactToInputField.swift
//  Reception
//
//  Created by Muukii on 8/26/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class ContactToInputFieldTransitionController: NSObject, UIViewControllerAnimatedTransitioning {

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
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ContactToViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            
            let inputFieldView = (toVC as! InputFieldTransition).inputFieldView
            let nextButton = (toVC as! InputFieldTransition).nextButton
           
            let transform = CATransform3DMakeTranslation(-offset, 0, 0)
            inputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
            
            let nextButtonCurrentAlpha = nextButton.alpha
            nextButton.alpha = 0
            
            UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                
                fromVC.inputFieldView.layer.transform = transform
                fromVC.tableView.layer.transform = transform
                }, completion: { (finish) -> Void in
                    
                    containerView.addSubview(toVC.view)
            }).animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                inputFieldView.layer.transform = CATransform3DIdentity
                nextButton.alpha = nextButtonCurrentAlpha
                }, completion: { (finish) -> Void in
                    transitionContext.completeTransition(true)
            })
            
        } else if operation == .Pop {
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! ContactToViewController
            
            let inputFieldView = (fromVC as! InputFieldTransition).inputFieldView
            let nextButton = (fromVC as! InputFieldTransition).nextButton
            let transform = CATransform3DMakeTranslation(-offset, 0, 0)
            
            toVC.inputFieldView.layer.transform = transform
            toVC.tableView.layer.transform = transform
            UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                inputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
                nextButton.alpha = 0
                }, completion: { (finish) -> Void in
                    
                    containerView.addSubview(toVC.view)
            }).animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                toVC.inputFieldView.layer.transform = CATransform3DIdentity
                toVC.tableView.layer.transform = CATransform3DIdentity
                }, completion: { (finish) -> Void in
                    
                    transitionContext.completeTransition(true)
            })
        }
    }
}