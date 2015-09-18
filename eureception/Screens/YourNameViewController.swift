//
//  YourNameViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class YourNameViewController: BaseTransactionViewController, InputFieldTransition {

    // MARK: Public
    var transaction: AppointmentTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.eureColor
        self.inputFieldView.backgroundColor = UIColor.eureColor
        
        self.messageLabel.textColor = UIColor.whiteColor()
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.messageLabel.text = "お客様のお名前をご記入ください"
        
        self.textField.attributedPlaceholder = NSAttributedString.eureBoldAttributedString(
            "YOUR NAME",
            color: UIColor.eureLightEureColor,
            size: 55
        )
        self.textField.textColor = UIColor.whiteColor()
        self.textField.tintColor = UIColor.whiteColor()
        self.textField.text = self.transaction?.visitor?.name
        
        JEDump(self.transaction)
        
        self.iconImageView.tintColor = UIColor.whiteColor()
        
        self.nextButton.enabled = false
                
        self.textField
            .rx_text
            .subscribe { [weak self] event in
                
                let result = event.value?.characters.count > 0
                self?.nextButton.enabled = result
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
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        let controller = CompanyNameViewController.viewControllerFromStoryboard()
        
        guard let name = self.textField.text else {
            
            return
        }
        
        guard !StringIsEmpty(name) else {
            
            return
        }
        
        var visitor = self.transaction?.visitor ?? AppointmentVisitor()
        visitor.name = name
        self.transaction?.visitor = visitor
        controller.appointmentTransaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
