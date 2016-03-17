//
//  CompletionToTopTransitionController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/9/15.
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


// MARK: - CompletionToTopTransitionController

final class CompletionToTopTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    // MARK: UIViewControllerAnimatedTransitioning

    @objc dynamic func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.7
    }
    
    @objc dynamic func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        containerView.insertSubview(toVC.view, atIndex: 0)
        UIView.animateWithDuration(
            0.2,
            delay: 0,
            options: .BeginFromCurrentState,
            animations: {
            
                fromVC.view.alpha = 0
            },
            completion: { _ in
                
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        )
    }
}
