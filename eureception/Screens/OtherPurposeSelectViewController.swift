//
//  OtherPurposeSelectViewController.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/30/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class OtherPurposeSelectViewController: BaseTransactionViewController {
    
    // MARK: Public 
    
    @IBOutlet dynamic weak var messageLabel: UILabel!
    @IBOutlet dynamic weak var selectView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.messageLabel.textColor = UIColor.eureColor
        self.messageLabel.text = "詳細なご用件をお選びください"
        
        self.deliveryButton.titleLabel?.text = "Delivery"
        self.deliveryButton.subtitleLabel?.text = "配達"
        self.otherButton.titleLabel?.text = "Other"
        self.otherButton.subtitleLabel?.text = "その他"
    }
    
    // MARK: Private
    @IBOutlet private dynamic weak var deliveryButton: PurposeButton!
    @IBOutlet private dynamic weak var otherButton: PurposeButton!
    
    @IBAction private dynamic func handleDeliveryButton(sender: AnyObject) {
        
        let controller = ConfirmOtherPresetViewController.viewControllerFromStoryboard()
        controller.transaction = OtherTransaction.Delivery()
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction private dynamic func handleOtherButton(sender: AnyObject) {
        
        let controller = CompanyNameViewController.viewControllerFromStoryboard()
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
