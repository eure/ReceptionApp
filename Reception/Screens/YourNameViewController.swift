//
//  YourNameViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import ReactiveCocoa

class YourNameViewController: BaseTransactionViewController, InputFieldTransition {

    // MARK: Public
    var transaction: AppointTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.attributedPlaceholder = NSAttributedString.eureExoDemiBoldAttributedString(
            "YOUR NAME",
            color: UIColor.eureLightGrayTextColor,
            size: 60
        )
        self.textField.textColor = UIColor.eureBlackTextColor
        self.textField.tintColor = UIColor.eureColor
        
        self.iconImageView.tintColor = UIColor.eureColor
        
        self.nextButton.enabled = false
        
        self.textField
            .rac_signalForControlEvents(UIControlEvents.EditingChanged)
            .toSignalProducer()
            .map { ($0 as! UITextField).text ?? "" }
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { [weak self] event in
                    
                    let result = event.value?.characters.count > 0
                    self?.nextButton.enabled = result
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
    @IBOutlet private dynamic weak var textField: UITextField!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        let controller = CompanyNameViewController.viewControllerFromStoryboard()
        
        guard let name = self.textField.text else {
            
            return
        }
        
        guard !StringIsEmpty(name) else {
            
            return
        }
        
        let customer = Customer(name: name)
        self.transaction?.customer = customer
        controller.transaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
