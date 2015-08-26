//
//  ConfirmViewController.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class ConfirmViewController: BaseTransactionViewController {

    // MARK: Public
    
    var transaction: AppointTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.icons.forEach { $0.tintColor = UIColor.eureLightGrayTextColor }
        
        self.contactToLabel.attributedText = NSAttributedString.eureAttributedString(transaction?.account.nameJa ?? "", color: UIColor.blackColor(), size: 32)
        
        if let customer = transaction?.customer {
            let size: CGFloat = 32
            self.nameLabel.attributedText = NSAttributedString.eureAttributedString(customer.name ?? "", color: UIColor.blackColor(), size: size)
            
            self.companyLabel.attributedText = NSAttributedString.eureAttributedString(customer.companyName, color: UIColor.blackColor(), size: size)
                        
            self.countLabel.attributedText = NSAttributedString.eureAttributedString("\(customer.numberOfPersons)人", color: UIColor.blackColor(), size: size)
        }
        
        self.messageLabel.font = UIFont.eureFont(size: 18)
        self.messageLabel.text = "以下、内容をご確認ください"
        self.messageLabel.textColor = UIColor.eureColor
        
        self.labels.forEach { label in
            
            
        }
    }
    
    // Use animation.
    @IBOutlet dynamic weak var submitButton: SubmitButton!
    @IBOutlet dynamic weak var contactToView: UIView!
    @IBOutlet dynamic weak var nameView: UIView!
    @IBOutlet dynamic weak var companyNameView: UIView!
    @IBOutlet dynamic weak var countview: UIView!
    @IBOutlet dynamic weak var messageLabel: UILabel!

    // MARK: Private
    @IBOutlet private dynamic weak var contactToIconImageView: UIImageView!
    @IBOutlet private dynamic weak var nameIconImageView: UIImageView!
    @IBOutlet private dynamic weak var companyNameIconImageView: UIImageView!
    @IBOutlet private dynamic weak var countIconImageView: UIImageView!
    
    @IBOutlet private dynamic weak var contactToLabel: UILabel!
    @IBOutlet private dynamic weak var nameLabel: UILabel!
    @IBOutlet private dynamic weak var companyLabel: UILabel!
    @IBOutlet private dynamic weak var countLabel: UILabel!
    
    @IBOutlet private dynamic var icons: [UIImageView]!
    @IBOutlet private dynamic var labels: [UILabel]!
    
    @IBAction private dynamic func handleSubmitButton(sender: AnyObject) {
        
        let controller = CompletionViewController.viewControllerFromStoryboard()
        
        self.transaction?.saveToParse()
        
        guard let transaction = self.transaction else {
            return
        }
        SlackDispatcher.call(transaction)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
