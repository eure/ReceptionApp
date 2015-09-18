//
//  ConfirmViewController.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class ConfirmAppointmentViewController: BaseConfirmViewController {

    // MARK: Public
    
    var transaction: AppointmentTransaction?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.eureColor
        self.contactToView.backgroundColor = UIColor.eureColor
        self.nameView.backgroundColor = UIColor.eureColor
        self.companyNameView.backgroundColor = UIColor.eureColor
        self.countview.backgroundColor = UIColor.eureColor
        
        self.icons.forEach { $0.tintColor = UIColor.whiteColor() }
        
        self.contactToLabel.attributedText = NSAttributedString.eureAttributedString(self.transaction?.user.nameJa ?? "", color: UIColor.whiteColor(), size: 32)
        
        if let visitor = self.transaction?.visitor {
            let size: CGFloat = 32
            self.nameLabel.attributedText = NSAttributedString.eureAttributedString(visitor.name ?? "", color: UIColor.whiteColor(), size: size)
            
            self.companyLabel.attributedText = NSAttributedString.eureAttributedString(visitor.companyName, color: UIColor.whiteColor(), size: size)
                        
            self.countLabel.attributedText = NSAttributedString.eureAttributedString("\(visitor.numberOfPersons)人", color: UIColor.whiteColor(), size: size)
        }
        
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.messageLabel.text = "以下、内容をご確認ください"
        self.messageLabel.textColor = UIColor.whiteColor()
        
        self.labels.forEach { label in
            
        }
    }
    
    override dynamic func handleSubmitButton(sender: AnyObject) {
        
        let controller = CompletionViewController.viewControllerFromStoryboard()
        
        guard let transaction = self.transaction else {
            return
        }
        
        Container.VisitorsModel.sendVisitor(transaction: transaction) { (result) -> Void in
            
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // Use animation.
    @IBOutlet dynamic weak var contactToView: UIView!
    @IBOutlet dynamic weak var nameView: UIView!
    @IBOutlet dynamic weak var companyNameView: UIView!
    @IBOutlet dynamic weak var countview: UIView!

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
    
}
