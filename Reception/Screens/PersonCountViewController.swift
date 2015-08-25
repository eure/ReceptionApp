//
//  PersonCountViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class PersonCountViewController: BaseTransactionViewController {

    var transaction: AppointTransaction?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.minusButton.tintColor = UIColor.eureColor
        self.plusButton.tintColor = UIColor.eureColor
        self.iconImageView.tintColor = UIColor.eureColor
        
        self.count = 1
    }
    
    private var count: Int = 0 {
        didSet {
            
            guard count >= 0 else {
                return
            }
            
            self.countLabel.attributedText = NSAttributedString.eureExoDemiBoldAttributedString(
                "\(self.count)人",
                color: UIColor.blackColor(),
                size: 60
            )
        }
    }
    
    @IBOutlet private dynamic weak var countLabel: UILabel!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var minusButton: UIButton!
    @IBOutlet private dynamic weak var plusButton: UIButton!
    @IBAction func handleMinusButton(sender: AnyObject) {
        
        self.count--
    }
    @IBAction func handlePlusButton(sender: AnyObject) {
        
        self.count++
    }
    
    @IBAction func handleNextButton(sender: AnyObject) {
        
        self.transaction?.customer?.numberOfPersons = self.count
        
        let controller = ConfirmViewController.viewControllerFromStoryboard()
        controller.transaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
