//
//  ConfirmViewController.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class ConfirmViewController: BaseTransactionViewController {

    var transaction: AppointTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.icons.forEach { $0.tintColor = UIColor.eureLightGrayTextColor }
        
        self.contactToLabel.text = transaction?.account.nameJa
        
        if let customer = transaction?.customer {
            let size: CGFloat = 32
            self.nameLabel.attributedText = NSAttributedString.eureExoDemiBoldAttributedString(customer.name ?? "", color: UIColor.blackColor(), size: size)
            
            self.companyLabel.attributedText = NSAttributedString.eureExoDemiBoldAttributedString(customer.companyName, color: UIColor.blackColor(), size: size)
            
            self.mailAddressLabel.attributedText = NSAttributedString.eureExoDemiBoldAttributedString(customer.mailAddress, color: UIColor.blackColor(), size: size)
            
            self.countLabel.attributedText = NSAttributedString.eureExoDemiBoldAttributedString("\(customer.numberOfPersons)人", color: UIColor.blackColor(), size: size)
        }
        
        self.messageLabel.text = "以下、内容をご確認ください"
        self.messageLabel.textColor = UIColor.eureColor
        
        self.labels.forEach { label in
            
            
        }
    }

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var contactToIconImageView: UIImageView!
    @IBOutlet weak var nameIconImageView: UIImageView!
    @IBOutlet weak var companyNameIconImageView: UIImageView!
    @IBOutlet weak var mailAddressIconImageView: UIImageView!
    @IBOutlet weak var countIconImageView: UIImageView!
    
    @IBOutlet weak var contactToLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var mailAddressLabel: UILabel!
    @IBOutlet var icons: [UIImageView]!
    @IBOutlet var labels: [UILabel]!
    
    @IBOutlet weak var submitButton: SubmitButton!
    @IBAction func handleSubmitButton(sender: AnyObject) {
        
        let controller = CompletionViewController.viewControllerFromStoryboard()
        
        self.transaction?.saveToParse()
        
        guard let transaction = self.transaction else {
            return
        }
        SlackDispatcher.call(transaction)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
