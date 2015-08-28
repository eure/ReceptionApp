//
//  OtherPurposeViewController.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class OtherPurposeViewController: BaseTransactionViewController, InputFieldTransition {
    
    @IBOutlet weak var inputFieldView: UIView!
    @IBOutlet dynamic weak var nextButton: NextButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.messageLabel.text = "ご用件をご記入ください"
        self.messageLabel.textColor = UIColor.eureColor
        self.iconImageView.tintColor = UIColor.eureColor
        self.textView.tintColor = UIColor.eureColor
        
        self.textViewMask.colors = [
            UIColor.clearColor().CGColor,
            UIColor.whiteColor().CGColor,
            UIColor.whiteColor().CGColor,
            UIColor.clearColor().CGColor,
        ]
        
        self.textViewMask.locations = [
            0,
            0.02,
            0.98,
            1
        ]
        
        self.textViewMask.startPoint = CGPoint(x: 0.5, y: 0)
        self.textViewMask.endPoint = CGPoint(x: 0.5, y: 1)
        self.textViewContainerView.layer.mask = textViewMask
        
        self.textView.textContainerInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        
        self.nextButton.enabled = false
        
        self.textView.rac_textSignal()
            .toSignalProducer()
            .map { ($0 as! String).characters.count }
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { [weak self] event in
                    
                    self?.textViewPlaceHolder.hidden = event.value > 0
                    self?.nextButton.enabled = event.value > 0
                }
        }
        
        self.textViewPlaceHolder.attributedText = NSAttributedString(string: "REASON FOR VISIT", attributes: [
            NSKernAttributeName : NSNumber(integer: 6),
            NSFontAttributeName :  UIFont.eureBoldFont(size: 55),
            NSForegroundColorAttributeName : UIColor(hexString: "#E6E6E6")!,
            ]
        )
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.textViewMask.frame = self.textView.bounds
    }
    
    // MARK: Private
    @IBOutlet private dynamic weak var textViewPlaceHolder: UILabel!
    @IBOutlet private dynamic weak var messageLabel: UILabel!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var textViewContainerView: UIView!
    @IBOutlet private dynamic weak var textView: UITextView!
    private let textViewMask = CAGradientLayer()
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        let controller = ConfirmOtherViewController.viewControllerFromStoryboard()
        guard let purpose = self.textView.text else {
            return
        }
        let visitor = OtherVisitor(purpose: purpose)
        let transaction = OtherTransaction(visitor: visitor)
        controller.transaction = transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}