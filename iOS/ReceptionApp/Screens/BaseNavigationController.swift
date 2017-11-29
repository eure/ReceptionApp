//
//  BaseNavigationController.swift
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

import UIKit


// MARK: - BaseNavigationController

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
    }
    
    
    // MARK: UINavigationControllerDelegate
    
    @objc dynamic func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch (fromVC, toVC) {
            
        case
        (is TopViewController, is ContactToViewController),
        (is ContactToViewController, is TopViewController):
            return TopToContactTransitionController(operation: operation)
            
        case
        (is TopViewController, is YourNameViewController),
        (is YourNameViewController, is TopViewController):
            return TopToInterviewTransitionController(operation: operation)
            
        case
        (is TopViewController, is OtherPurposeSelectViewController),
        (is OtherPurposeSelectViewController, is TopViewController):
            return TopToPurposeSelectTransitionController(operation: operation)
            
        case
        (is ContactToViewController, is InputFieldTransition),
        (is InputFieldTransition, is ContactToViewController):
            return ContactToInputFieldTransitionController(operation: operation)
            
        case
        (is InputFieldTransition, is InputFieldTransition):
            return InputFieldTransitionController(operation: operation)
            
        case
        (is ConfirmAppointmentViewController, is CompletionViewController),
        (is ConfirmOtherViewController, is CompletionViewController),
        (is ConfirmOtherPresetViewController, is CompletionViewController):
            return ConfirmToCompletionTransitionController()
            
        case
        (is CompletionViewController, is TopViewController):
            return CompletionToTopTransitionController()
            
        case
        (is InputFieldTransition, is ConfirmAppointmentViewController),
        (is ConfirmAppointmentViewController, is InputFieldTransition):
            return InputFieldToConfirmAppointmentTransitionController(operation: operation)
            
        case
        (is InputFieldTransition, is ConfirmOtherViewController),
        (is ConfirmOtherViewController, is InputFieldTransition):
            return InputFieldToConfirmOtherTransitionController(operation: operation)
            
        case
        (is OtherPurposeSelectViewController, is InputFieldTransition),
        (is InputFieldTransition, is OtherPurposeSelectViewController):
            return PurposeSelectToInputFieldTransitionController(operation: operation)
            
        case
        (is OtherPurposeSelectViewController, is ConfirmOtherPresetViewController),
        (is ConfirmOtherPresetViewController, is OtherPurposeSelectViewController):
            return PurposeSelectToConfirmOtherPresetTransitionController(operation: operation)
            
        default:
            return nil
        }
    }
}
