//
//  NetworkManager.swift
//  ReceptionApp
//
//  Created by Kazuki Yusa on 3/4/16.
//  Copyright © 2016 eureka, Inc. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {

    static let instance = NetworkManager()
    
    func setReachablityManager() {
        
        self.reachablityManager?.listener = { [weak self] _ in
            
            self?.showAlertIfNeeded()
        }
        self.reachablityManager?.startListening()
        self.showAlertIfNeeded()
    }
    
    deinit {
        
        self.reachablityManager?.stopListening()
    }
    
    private let reachablityManager = NetworkReachabilityManager()
    private var reachable: Bool?
    private var alert: UIAlertController?
    
    private func showAlertIfNeeded() {
        
        if self.reachablityManager?.isReachable == true {
            
            self.alert?.dismissViewControllerAnimated(true, completion: nil)
        } else {
            
            self.alert = UIAlertController(
                title: "NetworkManager.alert.notWiFi".l10n,
                message: "",
                preferredStyle: .Alert
            )
            self.alert?.addAction(UIAlertAction(title: "OK", style: .Default, handler: { [weak self] (_) -> Void in
                
                self?.alert?.dismissViewControllerAnimated(true, completion: nil)
                self?.showAlertIfNeeded()
            }))
            
            guard let alert = self.alert else {
                
                return
            }
            UIViewController.topmostPresentedViewController()?.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
