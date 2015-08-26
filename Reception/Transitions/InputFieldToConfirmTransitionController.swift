//
//  InputFieldToConfirmTransitionController.swift
//  Reception
//
//  Created by Muukii on 8/26/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class InputFieldToConfirmTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationControllerOperation = .None
    
    convenience init(operation: UINavigationControllerOperation) {
        
        self.init()
        self.operation = operation
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        
        let offset = UIScreen.mainScreen().bounds.width
        
        if operation == .Push {
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ConfirmViewController
            let inputFieldView = (fromVC as! InputFieldTransition).inputFieldView
            let nextButotn = (fromVC as! InputFieldTransition).nextButton
            
            let contactToView = toVC.contactToView
            let nameView = toVC.nameView
            let companyNameView = toVC.companyNameView
            let mailAddressView = toVC.mailAddressView
            let countview = toVC.countview
            let submitButton = toVC.submitButton
            let messageLabel = toVC.messageLabel
            
            let initTransform = CATransform3DMakeTranslation(offset, 0, 0)
            
            contactToView.layer.transform = initTransform
            nameView.layer.transform = initTransform
            companyNameView.layer.transform = initTransform
            mailAddressView.layer.transform = initTransform
            countview.layer.transform = initTransform
            submitButton.alpha = 0
            messageLabel.alpha = 0
            
            UIView.animateAndChainWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                
                nextButotn.alpha = 0
                }, completion: { (finish) -> Void in
                
            })
            
            UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                inputFieldView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
                
                }, completion: { (finish) -> Void in
                    
                    containerView.addSubview(toVC.view)
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        messageLabel.alpha = 1
                        contactToView.layer.transform = CATransform3DIdentity
                        }, completion: { (finish) -> Void in
                            
                    })
                    
                    UIView.animateWithDuration(0.3, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        nameView.layer.transform = CATransform3DIdentity
                        }, completion: { (finish) -> Void in
                            
                    })
                    
                    UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        companyNameView.layer.transform = CATransform3DIdentity
                        }, completion: { (finish) -> Void in
                            
                    })
                    
                    UIView.animateWithDuration(0.3, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        mailAddressView.layer.transform = CATransform3DIdentity
                        }, completion: { (finish) -> Void in
                            
                    })
                    
                    UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        countview.layer.transform = CATransform3DIdentity
                        submitButton.alpha = 1
                        }, completion: { (finish) -> Void in
                            
                            transitionContext.completeTransition(true)
                    })
            })
            
        } else if operation == .Pop {
            
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ConfirmViewController
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
            
            let inputFieldView = (toVC as! InputFieldTransition).inputFieldView
            let nextButotn = (toVC as! InputFieldTransition).nextButton
            
            let contactToView = fromVC.contactToView
            let nameView = fromVC.nameView
            let companyNameView = fromVC.companyNameView
            let mailAddressView = fromVC.mailAddressView
            let countview = fromVC.countview
            let submitButton = fromVC.submitButton
            let messageLabel = fromVC.messageLabel
            
            let transform = CATransform3DMakeTranslation(offset, 0, 0)
            
            nextButotn.alpha = 0
            inputFieldView.layer.transform = CATransform3DMakeTranslation(-offset, 0, 0)
            
            containerView.insertSubview(toVC.view, atIndex: 0)

            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                submitButton.alpha = 0
                messageLabel.alpha = 0
                
                contactToView.layer.transform = transform
                }, completion: { (finish) -> Void in
                    
            })
            
            UIView.animateWithDuration(0.3, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                nameView.layer.transform = transform
                }, completion: { (finish) -> Void in
                    
            })
            
            UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                companyNameView.layer.transform = transform
                }, completion: { (finish) -> Void in
                    
            })
            
            UIView.animateWithDuration(0.3, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                mailAddressView.layer.transform = transform
                }, completion: { (finish) -> Void in
                    
            })
            
            UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                
                countview.layer.transform = transform
                
                }, completion: { (finish) -> Void in
                    
                    fromVC.view.removeFromSuperview()
                    
                    UIView.animateAndChainWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        inputFieldView.layer.transform = CATransform3DIdentity
                        nextButotn.alpha = 1
                        
                        }, completion: { (finish) -> Void in
                            transitionContext.completeTransition(true)
                        })
                    
            })

        }
    }
}