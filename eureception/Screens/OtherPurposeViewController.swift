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
    
    var transaction: OtherTransaction?
    
    @IBOutlet weak var inputFieldView: UIView!
    @IBOutlet dynamic weak var nextButton: NextButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.textView.font = UIFont.eureFont(size: 55)
        self.messageLabel.text = "ご用件をご記入ください"
        self.messageLabel.textColor = UIColor.eureColor
        self.iconImageView.tintColor = UIColor.eureColor
        self.textView.tintColor = UIColor.eureColor
        
        self.textView.text = self.transaction?.visitor.purpose
        
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
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textView.becomeFirstResponder()
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
        JEDump(self.transaction?.visitor.companyName)
        self.transaction?.visitor.purpose = purpose
        controller.transaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
