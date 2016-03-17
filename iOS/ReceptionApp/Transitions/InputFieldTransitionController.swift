//
//  InputFieldTransitionController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/26/15.
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

import EasyAnimation


// MARK: - InputFieldTransition

protocol InputFieldTransition {
    
    var inputFieldView: UIView! { get }
    var nextButton: NextButton! { get }
}


// MARK: - InputFieldTransitionController

final class InputFieldTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    
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
            animations: {
                
                switch self.operation {
                    
                case .Push:
                    fromInputFieldView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
                    
                case .Pop:
                    fromInputFieldView.layer.transform = CATransform3DMakeTranslation(offset, 0, 0)
                    
                case .None:
                    break
                }
            },
            completion: { _ in
                
                containerView.addSubview(toVC.view)
            }
        ).animateWithDuration(
            0.4,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 1,
            options: .BeginFromCurrentState,
            animations: {
                
                toInputFieldView.layer.transform = CATransform3DIdentity
            },
            completion: { _ in
                
                transitionContext.completeTransition(true)
            }
        )
    }
    
    
    // MARK: Private
    
    private let operation: UINavigationControllerOperation
}