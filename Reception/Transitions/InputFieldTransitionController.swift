//
//  InputFieldTransitionController.swift
//  Reception
//
//  Created by Muukii on 8/26/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit
import EasyAnimation

protocol InputFieldTransition {
    var inputFieldView: UIView! { get }
}

class InputFieldTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationControllerOperation = .None
    
    convenience init(operation: UINavigationControllerOperation) {
        
        self.init()
        self.operation = operation
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        let fromInputFieldView = (fromVC as! InputFieldTransition).inputFieldView
        let toInputFieldView = (toVC as! InputFieldTransition).inputFieldView
        
        let offset = UIScreen.mainScreen().bounds.width
        
        switch self.operation {
        case .Push:
            toInputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
        case .Pop:
            toInputFieldView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
        case .None:
            break
        }
        UIView.animateAndChainWithDuration(
            0.4,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: .BeginFromCurrentState,
            animations: { () -> Void in
                
                switch self.operation {
                case .Push:
                    fromInputFieldView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
                case .Pop:
                    fromInputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
                case .None:
                    break
                }
            }) { (finish) -> Void in
                
                containerView.addSubview(toVC.view)
                
        }.animateWithDuration(
            0.4,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 1,
            options: .BeginFromCurrentState,
            animations: { () -> Void in
                
                toInputFieldView.layer.transform = CATransform3DIdentity
            }) { (finish) -> Void in
                
                transitionContext.completeTransition(true)
        }
        
    }
}