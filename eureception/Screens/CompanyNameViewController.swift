//
//  CompanyNameViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CompanyNameViewController : BaseTransactionViewController, InputFieldTransition {

    // MARK: Public
    var otherTransaction: OtherTransaction?
    var appointmentTransaction: AppointmentTransaction?
    
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
        
        if let transaction = self.appointmentTransaction {
            
            self.textView.text = transaction.visitor?.companyName
        }
        
        if let transaction = self.otherTransaction {
            
            self.textView.text = transaction.visitor?.companyName
        }
        
        self.textView.tintColor = UIColor.eureColor
        self.iconImageView.tintColor = UIColor.eureColor
                     
        self.textView
            .rx_text
            .map { $0.characters.count }
            .subscribe { [weak self] event in
                guard let value = event.value else {
                    return
                }
                self?.textViewPlaceHolder.hidden = value > 0
                self?.nextButton.enabled = value > 0
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textView.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.textViewMask.frame = self.textViewContainerView.bounds
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
        
        if let transaction = self.appointmentTransaction {
            
            let controller = PersonCountViewController.viewControllerFromStoryboard()
            transaction.visitor?.companyName = companyName
            controller.transaction = transaction
            self.navigationController?.pushViewController(controller, animated: true)
            
            return
        }
        
        let controller = OtherPurposeViewController.viewControllerFromStoryboard()
        
        var visitor = OtherVisitor()
        visitor.companyName = companyName
        var transaction = OtherTransaction()
        transaction.visitor = visitor
        
        self.otherTransaction = transaction
        controller.transaction = transaction
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

