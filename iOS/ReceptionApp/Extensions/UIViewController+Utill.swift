//
//  UIViewControllerUtill.swift
//  ReceptionApp
//
//  Created by KazukiYusa on 8/10/16.
//  Copyright © 2016 eureka, Inc. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func setGradient() {
        
        if let _ = self.gradientLayer { return }
        
        let topColor = Configuration.Color.backgroundColor
        let bottomColor = Configuration.Color.backgroundGradientColor
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    var gradientLayer: CAGradientLayer? {
        
        get {
            
            guard let value = objc_getAssociatedObject(self, &StoredProperties.gradientLayer) as? CAGradientLayer else {
                return nil
            }
            return value
        }
        set {
            
            objc_setAssociatedObject(
                self,
                &StoredProperties.gradientLayer,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    private struct StoredProperties {
        
        static var gradientLayer: Void?
    }
}
