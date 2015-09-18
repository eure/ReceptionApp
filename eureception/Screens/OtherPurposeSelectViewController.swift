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
        
        self.view.backgroundColor = UIColor.eureColor
        self.selectView.backgroundColor = UIColor.eureColor
        
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.messageLabel.textColor = UIColor.whiteColor()
        self.messageLabel.text = "詳細なご用件をお選びください"
        
        
        self.deliveryButton.titleLabel?.attributedText = NSAttributedString(string: "DELIVERY", attributes: [
            NSKernAttributeName : NSNumber(integer: 6),
            NSFontAttributeName : UIFont.eureBoldFont(size: 35),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        
        self.deliveryButton.subtitleLabel?.attributedText = NSAttributedString(string: "納品", attributes: [
            NSKernAttributeName : NSNumber(integer: 2),
            NSFontAttributeName : UIFont.eureBoldFont(size: 17),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        
        self.otherButton.titleLabel?.attributedText = NSAttributedString(string: "OTHER", attributes: [
            NSKernAttributeName : NSNumber(integer: 6),
            NSFontAttributeName : UIFont.eureBoldFont(size: 35),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        
        self.otherButton.subtitleLabel?.attributedText = NSAttributedString(string: "その他", attributes: [
            NSKernAttributeName : NSNumber(integer: 2),
            NSFontAttributeName : UIFont.eureBoldFont(size: 17),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
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
