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
        
        return nil
    }
}
