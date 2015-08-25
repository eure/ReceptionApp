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
    var transaction: AppointTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.attributedPlaceholder = NSAttributedString.eureExoDemiBoldAttributedString(
            "COMPANY NAME",
            color: UIColor.eureLightGrayTextColor,
            size: 60
        )
        self.textField.tintColor = UIColor.eureColor
        
        self.iconImageView.tintColor = UIColor.eureColor
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    @IBOutlet dynamic weak var inputFieldView: UIView!
    
    // MARK: Private
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var textField: UITextField!
    @IBOutlet private dynamic weak var nextButton: NextButton!
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        let controller = MailAddressViewController.viewControllerFromStoryboard()
        
        guard let value = self.textField.text else {
            
            return
        }
        
        self.transaction?.customer?.companyName = value
        controller.transaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

