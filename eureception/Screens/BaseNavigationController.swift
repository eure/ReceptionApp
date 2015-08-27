//
//  BaseNavigationController.swift
//  Reception
//
//  Created by Muukii on 8/9/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch (fromVC, toVC) {
        case ((_ as TopViewController), (_ as ContactToViewController)), ((_ as ContactToViewController), (_ as TopViewController)):
            return TopToContactTransitionController(operation: operation)
            
        case ((_ as ContactToViewController), (_ as InputFieldTransition)), ((_ as InputFieldTransition), (_ as ContactToViewController)):
            
            return ContactToInputFieldTransitionController(operation: operation)
            
        case ((_ as InputFieldTransition), (_ as InputFieldTransition)):
            
            return InputFieldTransitionController(operation: operation)
            
        case ((_ as ConfirmViewController), (_ as CompletionViewController)):
            
            return ConfirmToCompletionTransitionController()
            
        case ((_ as CompletionViewController), (_ as TopViewController)):
            
            return CompletionToTopTransitionController()
            
        case ((_ as InputFieldTransition), (_ as ConfirmViewController)), ((_ as ConfirmViewController), (_ as InputFieldTransition)):
            
            return InputFieldToConfirmTransitionController(operation: operation)
        default:
            break
        }
        return nil
    }
}
