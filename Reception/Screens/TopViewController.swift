//
//  TopViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class TopViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.logoImageView.tintColor = UIColor.eureColor
        self.welcomeLabel.text = "ようこそeurekaへ。 ご用件をお選びください"
        self.welcomeLabel.textColor = UIColor.eureColor
        
        self.appointButton.tintColor = UIColor.eureColor
        self.generalButton.tintColor = UIColor.eureColor
        
        self.appointButton.title = "APPOINTMENT"
        self.generalButton.title = "OTHER"
        
        self.welcomeBottomLabel.attributedText = NSAttributedString(string: "WELCOME!", attributes: [
            NSKernAttributeName : NSNumber(integer: 8),
            NSFontAttributeName : UIFont.exoDemiBold(size: 23),
            NSForegroundColorAttributeName : UIColor.eureColor,
            ]
        )
        
        self.appointButton.titleLabel?.attributedText = NSAttributedString(string: "APPOINTMENT", attributes: [
            NSKernAttributeName : NSNumber(integer: 8),
            NSFontAttributeName : UIFont(name: "Exo-DemiBold", size: 23)!,
            NSForegroundColorAttributeName : UIColor.eureColor,
            ]
        )
        
        self.generalButton.titleLabel?.attributedText = NSAttributedString(string: "OTHER", attributes: [
            NSKernAttributeName : NSNumber(integer: 8),
            NSFontAttributeName : UIFont(name: "Exo-DemiBold", size: 23)!,
            NSForegroundColorAttributeName : UIColor.eureColor,
            ]
        )
    }
    
    @IBOutlet dynamic weak var buttonView: UIView!
    @IBOutlet dynamic weak var welcomeLabel: UILabel!
    @IBOutlet dynamic weak var welcomeBottomLabel: UILabel!
    
    // MARK: Private
    @IBOutlet private dynamic weak var generalButton: TopButton!
    @IBOutlet private dynamic weak var appointButton: TopButton!    
    @IBOutlet private dynamic weak var logoImageView: UIImageView!
    
    @IBAction func handleApointButton(sender: AnyObject) {
        
        let controller = ContactToViewController.viewControllerFromStoryboard()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func handleGeneralButton(sender: AnyObject) {
        
    }
}
