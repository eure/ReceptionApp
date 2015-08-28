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
    var transaction: AppointmentTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageLabel.textColor = UIColor.eureColor
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.messageLabel.text = "貴社名をご記入ください"

        self.textField.attributedPlaceholder = NSAttributedString.eureBoldAttributedString(
            "COMPANY NAME",
            color: UIColor.eureLightGrayTextColor,
            size: 55
        )
        self.textField.tintColor = UIColor.eureColor
        self.textField.text = self.transaction?.visitor?.companyName
        
        self.iconImageView.tintColor = UIColor.eureColor
        
        // Do any additional setup after loading the view.
        
        self.textField
            .rac_signalForControlEvents(UIControlEvents.EditingChanged)
            .toSignalProducer()
            .map { ($0 as! UITextField).text ?? "" }
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { [weak self] event in
                    
                    guard let string = event.value else {
                        return
                    }
                    
                    self?.transaction?.visitor?.companyName = string
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    @IBOutlet dynamic weak var inputFieldView: UIView!
    @IBOutlet dynamic weak var nextButton: NextButton!
    
    // MARK: Private
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var messageLabel: UILabel!
    @IBOutlet private dynamic weak var textField: UITextField!
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        let controller = PersonCountViewController.viewControllerFromStoryboard()
        controller.transaction = self.transaction
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

