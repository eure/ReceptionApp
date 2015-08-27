//
//  PersonCountViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class PersonCountViewController: BaseTransactionViewController, InputFieldTransition {

    // MARK: Public
    var transaction: AppointTransaction?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.minusButton.tintColor = UIColor.eureColor
        self.plusButton.tintColor = UIColor.eureColor
        self.iconImageView.tintColor = UIColor.eureColor
        
        self.count = self.transaction?.visitor?.numberOfPersons ?? 1
    }
    
    private var count: Int {
        get {
            return _count
        }
        set {
            
            guard newValue >= 1 else {
                return
            }
            
            self._count = newValue
            
            self.transaction?.visitor?.numberOfPersons = newValue
            
            self.countLabel.attributedText = NSAttributedString.eureBoldAttributedString(
                "\(self.count)人",
                color: UIColor.eureBlackTextColor,
                size: 55
            )
        }
    }
    
    private var _count: Int = 1
    
    @IBOutlet dynamic weak var inputFieldView: UIView!    
    @IBOutlet weak var nextButton: NextButton!
    
    // MARK: Private
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
        
        let controller = ConfirmViewController.viewControllerFromStoryboard()
        controller.transaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
