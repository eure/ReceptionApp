//
//  BaseTransactionViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class BaseTransactionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.logoImageView.tintColor = UIColor.eureColor
        self.backButton.tintColor = UIColor.eureColor
    }
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func handleBackButton(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}

func StringIsEmpty(string: String?) -> Bool {
    
    if let string = string {
        return string.isEmpty
    } else {
        return true
    }
}
