//
//  OtherPurposeSelectViewController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/30/15.
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

import Foundation
import UIKit


// MARK: - OtherPurposeSelectViewController

final class OtherPurposeSelectViewController: BaseTransactionViewController {
    
    // MARK: Internal
    
    @IBOutlet private(set) dynamic weak var selectView: UIView!
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = Configuration.Color.backgroundColor
        self.selectView.backgroundColor = Configuration.Color.backgroundColor
        
        self.messageLabel.font = Configuration.Font.baseBoldFont(size: 18)
        self.messageLabel.textColor = Configuration.Color.textColor
        self.messageLabel.text = "OtherPurposeSelectViewController.label.business".l10n
        
        self.deliveryButton.titleLabel?.attributedText = NSAttributedString(
            string: "DELIVERY",
            attributes: [
                NSKernAttributeName : NSNumber(integer: 6),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 35),
                NSForegroundColorAttributeName : Configuration.Color.textColor
            ]
        )
        self.deliveryButton.subtitleLabel?.attributedText = NSAttributedString(
            string: "OtherPurposeSelectViewController.label.delivery".l10n,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 2),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 17),
                NSForegroundColorAttributeName : Configuration.Color.textColor
            ]
        )
        self.otherButton.titleLabel?.attributedText = NSAttributedString(
            string: "OTHER",
            attributes: [
                NSKernAttributeName : NSNumber(integer: 6),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 35),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
        self.otherButton.subtitleLabel?.attributedText = NSAttributedString(
            string: "OtherPurposeSelectViewController.label.other".l10n,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 2),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 17),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
    }
    
    
    // MARK: Private
    
    @IBOutlet private dynamic weak var messageLabel: UILabel!
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
