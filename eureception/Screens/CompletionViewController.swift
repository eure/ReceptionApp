//
//  CompletionViewController.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import GCDKit

class CompletionViewController: BaseViewController {

    var transaction: AppointmentTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.eureColor

        self.iconImageView.tintColor = UIColor.whiteColor()
        
        self.titleLabel.attributedText = NSAttributedString(string: "THANK YOU!", attributes: [
            NSKernAttributeName : NSNumber(integer: 8),
            NSFontAttributeName : UIFont.eureBoldFont(size: 36),
            NSForegroundColorAttributeName : UIColor.eureColor,
            ]
        )
       
        self.subtitleLabel.attributedText = NSAttributedString(string: "受付が完了しました\nただいま担当者が参りますので\nもう少々お待ちくださいませ", attributes: [
            NSKernAttributeName : NSNumber(integer: 2),
            NSFontAttributeName : UIFont.eureBoldFont(size: 22),
            NSForegroundColorAttributeName : UIColor.eureColor,
            ]
        )
                
        self.titleLabel.textColor = UIColor.whiteColor()
        self.subtitleLabel.textColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        
        GCDBlock.after(.Main, delay: 10) { [weak self] () -> Void in
            
            self?.navigationController?.popToRootViewControllerAnimated(true)
        }
    }

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBAction func handleHomeButton(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
