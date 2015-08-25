//
//  CompletionViewController.swift
//  Reception
//
//  Created by Muukii on 8/25/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class CompletionViewController: BaseViewController {

    var transaction: AppointTransaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.eureColor

        self.iconImageView.tintColor = UIColor.whiteColor()
        self.titleLabel.text = "受け付けました"
        self.subtitleLabel.text = "ただいま係りの者が参りますので、\nもう少々お待ちくださいませ"
        
        self.titleLabel.textColor = UIColor.whiteColor()
        self.subtitleLabel.textColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBAction func handleHomeButton(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
