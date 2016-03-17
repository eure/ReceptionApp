//
//  InputFieldToConfirmOtherTransitionController.swift
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


// MARK: - InputFieldToConfirmOtherTransitionController

final class InputFieldToConfirmOtherTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    // MARK: Internal
    
    required init(operation: UINavigationControllerOperation) {
        
        self.operation = operation
        super.init()
    }
    
    
    // MARK: UIViewControllerAnimatedTransitioning
    
    @objc dynamic func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 1
    }
    
    @objc dynamic func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let offset = UIScreen.mainScreen().bounds.width
        switch self.operation {
            
        case .Push:
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ConfirmOtherViewController
            let inputFieldView = (fromVC as! InputFieldTransition).inputFieldView
            let nextButotn = (fromVC as! InputFieldTransition).nextButton
            
            let submitButton = toVC.submitButton
            let messageLabel = toVC.messageLabel
            let purposeView = toVC.purposeView
            let companyNameView = toVC.companyNameView
            
            let initTransform = CATransform3DMakeTranslation(offset, 0, 0)
            
            companyNameView.layer.transform  = initTransform
            purposeView.layer.transform = initTransform
            submitButton.alpha = 0
            messageLabel.alpha = 0
            
            UIView.animateAndChainWithDuration(
                0.3,
                delay: 0,
                options: [],
                animations: {
                
                    nextButotn.alpha = 0
                },
                completion: { _ in }
            )
            
            UIView.animateAndChainWithDuration(
                0.4,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: .BeginFromCurrentState,
                animations: {
                
                    inputFieldView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
                },
                completion: { _ in
                    
                    containerView.addSubview(toVC.view)
                    
                    UIView.animateWithDuration(
                        0.3,
                        delay: 0,
                        usingSpringWithDamping: 0.8,
                        initialSpringVelocity: 0,
                        options: .BeginFromCurrentState,
                        animations: {
                        
                            companyNameView.layer.transform = CATransform3DIdentity
                        },
                        completion: { _ in }
                    )
                    
                    UIView.animateWithDuration(
                        0.3,
                        delay: 0.05,
                        usingSpringWithDamping: 0.8,
                        initialSpringVelocity: 0,
                        options: .BeginFromCurrentState,
                        animations: {
                        
                            messageLabel.alpha = 1
                            submitButton.alpha = 1
                            purposeView.layer.transform = CATransform3DIdentity
                        },
                        completion: { _ in
                            
                            transitionContext.completeTransition(true)                            
                        }
                    )
                }
            )
            
        case .Pop:
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ConfirmOtherViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            
            let inputFieldView = (toVC as! InputFieldTransition).inputFieldView
            let nextButotn = (toVC as! InputFieldTransition).nextButton
            
            let submitButton = fromVC.submitButton
            let messageLabel = fromVC.messageLabel
            let purposeView = fromVC.purposeView
            let companyNameView = fromVC.companyNameView
            
            let transform = CATransform3DMakeTranslation(offset, 0, 0)
            
            nextButotn.alpha = 0
            inputFieldView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
            
            containerView.insertSubview(toVC.view, atIndex: 0)
            
            UIView.animateWithDuration(
                0.3,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .BeginFromCurrentState,
                animations: {
                
                    submitButton.alpha = 0
                    messageLabel.alpha = 0
                    
                    companyNameView.layer.transform = transform
                },
                completion: { _ in }
            )
        
            UIView.animateWithDuration(
                0.3,
                delay: 0.05,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .BeginFromCurrentState,
                animations: {
                
                    purposeView.layer.transform = transform
                },
                completion: { _ in
                    
                    fromVC.view.removeFromSuperview()
                    
                    UIView.animateAndChainWithDuration(
                        0.4,
                        delay: 0,
                        usingSpringWithDamping: 0.9,
                        initialSpringVelocity: 0,
                        options: .BeginFromCurrentState,
                        animations: {
                        
                            inputFieldView.layer.transform = CATransform3DIdentity
                            nextButotn.alpha = 1
                        },
                        completion: { _ in
                            
                            transitionContext.completeTransition(true)
                        }
                    )
                }
            )
            
        default:
            return
        }
    }
    
    
    // MARK: Private
    
    private let operation: UINavigationControllerOperation
}