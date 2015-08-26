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
        self.welcomeLabel.textColor = UIColor.eureColor
        
        self.appointButton.tintColor = UIColor.eureColor
        self.otherButton.tintColor = UIColor.eureColor
        
        self.welcomeBottomLabel.attributedText = NSAttributedString(string: "WELCOME!", attributes: [
            NSKernAttributeName : NSNumber(integer: 8),
            NSFontAttributeName : UIFont.eureFont(size: 23),
            NSForegroundColorAttributeName : UIColor.eureColor,
            ]
        )
        
        self.appointButton.titleLabel?.attributedText = NSAttributedString(string: "APPOINTMENT", attributes: [
            NSKernAttributeName : NSNumber(integer: 8),
            NSFontAttributeName : UIFont.eureFont(size: 23),
            NSForegroundColorAttributeName : UIColor.eureColor,
            ]
        )
        
        self.otherButton.titleLabel?.attributedText = NSAttributedString(string: "OTHER", attributes: [
            NSKernAttributeName : NSNumber(integer: 8),
            NSFontAttributeName : UIFont.eureFont(size: 23),
            NSForegroundColorAttributeName : UIColor.eureColor,
            ]
        )
    }
    
    @IBOutlet dynamic weak var welcomeLabel: UILabel!
    @IBOutlet dynamic weak var welcomeBottomLabel: UILabel!
    @IBOutlet dynamic weak var otherButton: TopButton!
    @IBOutlet dynamic weak var appointButton: TopButton!
    
    // MARK: Private
    @IBOutlet private dynamic weak var logoImageView: UIImageView!
    
    @IBAction func handleApointButton(sender: AnyObject) {
        
        let controller = ContactToViewController.viewControllerFromStoryboard()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func handleotherButton(sender: AnyObject) {
        
    }
}
