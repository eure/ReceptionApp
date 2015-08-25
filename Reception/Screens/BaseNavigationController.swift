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
            
        case ((_ as InputFieldTransition), (_ as InputFieldTransition)):
            
            return InputFieldTransitionController(operation: operation)
        default:
            break
        }
        return nil
    }
}
