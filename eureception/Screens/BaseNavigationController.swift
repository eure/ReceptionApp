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
            
        case ((_ as TopViewController), (_ as OtherPurposeSelectViewController)), ((_ as OtherPurposeSelectViewController), (_ as TopViewController)):
           
            return TopToPurposeSelectTransitionController(operation: operation)
            
        case ((_ as ContactToViewController), (_ as InputFieldTransition)), ((_ as InputFieldTransition), (_ as ContactToViewController)):
            
            return ContactToInputFieldTransitionController(operation: operation)
            
        case ((_ as InputFieldTransition), (_ as InputFieldTransition)):
            
            return InputFieldTransitionController(operation: operation)
            
        case ((_ as ConfirmAppointmentViewController), (_ as CompletionViewController)):
            
            return ConfirmAppointmentToCompletionTransitionController()
            
        case ((_ as ConfirmOtherViewController), (_ as CompletionViewController)):
            
            return ConfirmOtherToCompletionTransitionController()
            
        case ((_ as CompletionViewController), (_ as TopViewController)):
            
            return CompletionToTopTransitionController()
            
        case ((_ as InputFieldTransition), (_ as ConfirmAppointmentViewController)), ((_ as ConfirmAppointmentViewController), (_ as InputFieldTransition)):
            
            return InputFieldToConfirmAppointmentTransitionController(operation: operation)
            
        case ((_ as InputFieldTransition), (_ as ConfirmOtherViewController)), ((_ as ConfirmOtherViewController), (_ as InputFieldTransition)):
            
            return InputFieldToConfirmOtherTransitionController(operation: operation)
        default:
            break
        }
        return nil
    }
}
