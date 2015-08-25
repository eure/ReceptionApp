//
//  MailAddressViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class MailAddressViewController: BaseTransactionViewController {

    var transaction: AppointTransaction?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.attributedPlaceholder = NSAttributedString.eureExoDemiBoldAttributedString(
            "MAIL ADDRESS",
            color: UIColor.eureLightGrayTextColor,
            size: 60
        )
        self.textField.textColor = UIColor.eureBlackTextColor
        self.textField.tintColor = UIColor.eureColor
        
        self.iconImageView.tintColor = UIColor.eureColor
                
        self.textField
            .rac_signalForControlEvents(UIControlEvents.EditingChanged)
            .toSignalProducer()
            .map { ($0 as! UITextField).text ?? "" }
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { [weak self] event in
                    
                    guard let value = event.value else {
                        
                        return
                    }
                    
                    if value.characters.count == 0 {
                        
                        self?.nextButton.enabled = true
                        return
                    }
                    
                    let result: Bool = {
                        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
                        let result = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(value)
                        return result
                        }()
                    
                    self?.nextButton.enabled = result
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }

    @IBOutlet private dynamic weak var nextButton: NextButton!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var textField: UITextField!
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        func transition(value: String) {
            
            let controller = PersonCountViewController.viewControllerFromStoryboard()
            self.transaction?.customer?.mailAddress = value
            controller.transaction = self.transaction
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        guard let value = self.textField.text else {
            
            return
        }
        
        if StringIsEmpty(value) {
            
            transition(value)
            return
        }
        
        let result: Bool = {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            let result = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(value)
            return result
        }()
        
        if result {
            
            transition(value)
        }
    }    
}
