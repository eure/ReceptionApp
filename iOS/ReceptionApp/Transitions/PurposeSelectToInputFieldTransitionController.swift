//
//  PurposeSelectToInputFieldTransitionController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/30/15.
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


// MARK: - PurposeSelectToInputFieldTransitionController

final class PurposeSelectToInputFieldTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    // MARK: Internal
    
    required init(operation: UINavigationControllerOperation) {
        
        self.operation = operation
        super.init()
    }
    
    
    // MARK: UIViewControllerAnimatedTransitioning
    
    @objc dynamic func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.8
    }
    
    @objc dynamic func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let offset = UIScreen.mainScreen().bounds.width
        switch self.operation {
            
        case .Push:
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! OtherPurposeSelectViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            
            let inputFieldView = (toVC as! InputFieldTransition).inputFieldView
            let nextButton = (toVC as! InputFieldTransition).nextButton
           
            let transform = CATransform3DMakeTranslation(-offset, 0, 0)
            inputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
            
            let nextButtonCurrentAlpha = nextButton.alpha
            nextButton.alpha = 0
            
            UIView.animateAndChainWithDuration(
                0.4,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: [],
                animations: {
                
                    fromVC.selectView.layer.transform = transform
                },
                completion: { _ in
                    
                    containerView.addSubview(toVC.view)
                }
            ).animateWithDuration(
                0.4,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: [],
                animations: {
                
                    inputFieldView.layer.transform = CATransform3DIdentity
                    nextButton.alpha = nextButtonCurrentAlpha
                },
                completion: { _ in
                    
                    transitionContext.completeTransition(true)
                }
            )
            
        case .Pop:
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)  as! OtherPurposeSelectViewController
            
            let inputFieldView = (fromVC as! InputFieldTransition).inputFieldView
            let nextButton = (fromVC as! InputFieldTransition).nextButton
            
            let transform = CATransform3DMakeTranslation(-offset, 0, 0)
            toVC.selectView.layer.transform = transform
            
            UIView.animateAndChainWithDuration(
                0.4,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: [],
                animations: { () -> Void in
                
                    inputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
                    nextButton.alpha = 0
                },
                completion: { (finish) -> Void in
                    
                    containerView.addSubview(toVC.view)
                }
            ).animateWithDuration(
                0.4,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: [],
                animations: { () -> Void in
                
                    toVC.selectView.layer.transform = CATransform3DIdentity
                },
                completion: { (finish) -> Void in
                    
                    transitionContext.completeTransition(true)
                }
            )
            
        default:
            return
        }
    }
    
    
    // MARK: Private
    
    private let operation: UINavigationControllerOperation
}
