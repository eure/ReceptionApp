//
//  CompanyNameViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class CompanyNameViewController: BaseTransactionViewController, InputFieldTransition {

    // MARK: Public
    var transaction: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageLabel.textColor = UIColor.eureColor
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.textView.font = UIFont.eureFont(size: 55)
        self.messageLabel.text = "貴社名をご記入ください"

        self.textViewPlaceHolder.attributedText = NSAttributedString(string: "COMPANY NAME", attributes: [
            NSKernAttributeName : NSNumber(integer: 6),
            NSFontAttributeName :  UIFont.eureBoldFont(size: 55),
            NSForegroundColorAttributeName : UIColor(hexString: "#E6E6E6")!,
            ]
        )
        
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
        
        
        switch self.transaction {
        case (let transaction as AppointmentTransaction)?:
            
            self.textView.text = transaction.visitor?.companyName
        case (let transaction as OtherTransaction)?:
            
            self.textView.text = transaction.visitor.companyName
        default: break
        }
        
        self.textView.tintColor = UIColor.eureColor
        self.iconImageView.tintColor = UIColor.eureColor
        
        self.textView.rac_textSignal()
            .toSignalProducer()
            .map { ($0 as! String).characters.count }
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { [weak self] event in
                    
                    self?.textViewPlaceHolder.hidden = event.value > 0
                    self?.nextButton.enabled = event.value > 0
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textView.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.textViewMask.frame = self.textView.bounds
    }
    
    @IBOutlet dynamic weak var inputFieldView: UIView!
    @IBOutlet dynamic weak var nextButton: NextButton!
    
    // MARK: Private
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var messageLabel: UILabel!
    @IBOutlet private dynamic weak var textView: UITextView!
    @IBOutlet private dynamic weak var textViewContainerView: UIView!
    @IBOutlet private dynamic weak var textViewPlaceHolder: UILabel!
    private let textViewMask = CAGradientLayer()
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        let companyName = self.textView.text ?? ""
        
        switch self.transaction {
        case (let transaction as AppointmentTransaction)?:
            let controller = PersonCountViewController.viewControllerFromStoryboard()
            transaction.visitor?.companyName = companyName
            controller.transaction = transaction
            self.navigationController?.pushViewController(controller, animated: true)
            
        default:
            let controller = OtherPurposeViewController.viewControllerFromStoryboard()
            
            let visitor = OtherVisitor()
            let transaction = OtherTransaction(visitor: visitor)
            controller.transaction = transaction
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
    }
}

