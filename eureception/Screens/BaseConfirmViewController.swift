//
//  BaseConfirmViewController.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class BaseConfirmViewController: BaseTransactionViewController {
    
    
    @IBOutlet dynamic weak var messageLabel: UILabel!
    @IBOutlet dynamic weak var submitButton: SubmitButton!
    
    @IBAction dynamic func handleSubmitButton(sender: AnyObject) {
        
    }
}
