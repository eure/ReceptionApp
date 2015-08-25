//
//  CheckinViewController.swift
//  Reception
//
//  Created by Muukii on 8/8/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import ReactiveCocoa

class CheckinViewController: BaseViewController {

    // MARK: Public
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.tintAdjustmentMode = .Normal
        self.logoImageView.tintColor = UIColor.eureColor
        
        self.nameTextField.placeholder = JEL10n("CheckinViewController.textField.placeholder.yourName")
        self.mailAddressTextField.placeholder = JEL10n("CheckinViewController.textField.placeholder.yourMailAddress")
        self.contactNameTextField.placeholder = JEL10n("CheckinViewController.textField.placeholder.ContactName")
        
        let textColor = UIColor(white: 0, alpha: 0.7)
        let tintColor = UIColor.eurekaLightBackgroundColor
        
        func setAppearanceTextFiled(textField: UITextField) {
            
            textField.textColor = textColor
            textField.tintColor = tintColor
            textField.delegate = self
        }
        
        setAppearanceTextFiled(self.nameTextField)
        setAppearanceTextFiled(self.mailAddressTextField)
        setAppearanceTextFiled(self.contactNameTextField)
        setAppearanceTextFiled(self.companyNameTextField)
        
        self.contactNameTextField
            .rac_signalForControlEvents(UIControlEvents.EditingChanged)
            .toSignalProducer()
            .map { ($0 as! UITextField).text ?? "" }
            .filter { $0.characters.count > 0 }
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { event in
                 
                    guard let candidate = event.value else {
                        return
                    }
                    
                    if let controller = self.presentedViewController as? AccountsSuggestViewController {
                        
                        controller.candidate = candidate
                        return
                    }
                    
                    var targetRect = self.contactNameTextField.convertRect(self.contactNameTextField.bounds, toView: self.view)
                    targetRect.origin.y += 20
                    
                    struct Static {
                        static var controller: UIViewController?
                    }
                    let controller = AccountsSuggestViewController.viewControllerFromStoryboard()
                    controller.modalPresentationStyle = .Popover
                    controller.preferredContentSize = CGSize(width: 500, height: 300)
                    
                    controller.popoverPresentationController?.sourceView = self.view
                    controller.popoverPresentationController?.sourceRect = targetRect
                    controller.popoverPresentationController?.permittedArrowDirections = .Up
                    
                    controller.candidate = candidate
                    
                    controller.didSelectAccount = { [weak self, weak controller] account in
                        
                        self?.selectedAccount = account
                        self?.contactNameTextField.text = account.nameJa
                        controller?.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                    Static.controller = controller
                    
                    self.presentViewController(controller, animated: true, completion: nil)
                }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if touches.first?.view == self.view {
            
            self.view.endEditing(true)
        }
    }
    
    @IBOutlet dynamic weak var logoImageView: UIImageView!
    @IBOutlet dynamic weak var companyNameTextField: UITextField!
    @IBOutlet dynamic weak var nameTextField: UITextField!
    @IBOutlet dynamic weak var mailAddressTextField: UITextField!
    @IBOutlet dynamic weak var contactNameTextField: UITextField!
    @IBOutlet dynamic weak var contactButton: ContactButton!
    @IBOutlet dynamic weak var contactNameValidatedImaveView: UIImageView!
    @IBOutlet dynamic weak var companyValidatedImageView: UIImageView!
    @IBOutlet dynamic weak var yourNameValidatedImageView: UIImageView!
    @IBOutlet dynamic weak var mailAddressValidatedImageView: UIImageView!
    // MARK: Private
    
    private var selectedAccount: Account?
    
    @IBAction private dynamic func exitContactNameTextField(sender: AnyObject) {
        
        self.companyNameTextField.becomeFirstResponder()
    }
    
    @IBAction private dynamic func exitCompanyNameTextField(sender: AnyObject) {
        
        self.nameTextField.becomeFirstResponder()
    }
    
    @IBAction private dynamic func exitYourNameTextField(sender: AnyObject) {
        
        self.mailAddressTextField.becomeFirstResponder()
    }
    
    @IBAction private dynamic func exitYourMailAddressTextField(sender: UIButton) {
        
        sender.resignFirstResponder()
    }
    
    @IBAction func changedContactName(sender: AnyObject) {
        
    }
    
    @IBAction private dynamic func handleContactButton(sender: AnyObject) {
        
        guard self.validateContactName() &&
            self.validateCompanyName() &&
            self.validateName() &&
            self.validateMailAddress() else {
                
                return
        }
        
        guard let account = self.selectedAccount else {
            return
        }
        
        let customer = Customer(name: self.nameTextField.text!, numberOfPersons: 1, companyName: self.companyNameTextField.text, mailAddress: self.mailAddressTextField.text)
//        transaction.saveToParse()
        
        let controller = CompletionViewController.viewControllerFromStoryboard()
//        controller.transaction = transaction
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction private dynamic func handleBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func validateContactName() -> Bool {
        
        return self.selectedAccount != nil
    }
    
    private func validateCompanyName() -> Bool {
        
        return true
    }
    
    private func validateName() -> Bool {
        
        let result = !StringIsEmpty(self.nameTextField.text)
        self.updateValidateImageView(self.yourNameValidatedImageView, valid: result)
        return result
    }
    
    private func validateMailAddress() -> Bool {
        
        guard let candidate = self.mailAddressTextField.text else {
            
            self.updateValidateImageView(self.mailAddressValidatedImageView, valid: false)
            return false
        }
        
        if StringIsEmpty(candidate) {
            
            return true
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let result = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
        self.updateValidateImageView(self.mailAddressValidatedImageView, valid: result)
        return result
    }
    
    private func StringIsEmpty(string: String?) -> Bool {
        
        if let string = string {
            return string.isEmpty
        } else {
            return true
        }
    }
    
    private func updateValidateImageView(imageView: UIImageView, valid: Bool) {
        
        imageView.hidden = false
        if valid {
            
            imageView.image = UIImage(named: "valid_value")
        } else {
            
            imageView.image = UIImage(named: "invalid_value")
        }
        
    }
}

extension CheckinViewController: UITextFieldDelegate {
   
    func textFieldDidEndEditing(textField: UITextField) {
        
        switch textField {
        case self.contactNameTextField:
            self.validateContactName()
        case self.companyNameTextField:
            self.validateCompanyName()
        case self.nameTextField:
            self.validateName()
        case self.mailAddressTextField:
            self.validateMailAddress()
        default:
            break
        }
    }
}
