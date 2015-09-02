//
//  ConfirmOtherPresetViewController.swift
//  eureception
//
//  Created by Hiroshi Kimura on 9/2/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class ConfirmOtherPresetViewController: BaseConfirmViewController {
    
    var transaction: OtherTransaction?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.messageEnLabel.text = "Ready to send?"
        self.messageJaLabel.text = "担当者へ連絡します\nよろしいですか？"
        self.messageEnLabel.textColor = UIColor.eureColor
        self.messageEnLabel.font = UIFont.eureBoldFont(size: 45)
        self.messageJaLabel.textColor = UIColor.eureColor
        self.messageJaLabel.font = UIFont.eureBoldFont(size: 20)
    }
    
    @IBOutlet weak var messageEnLabel: UILabel!
    @IBOutlet weak var messageJaLabel: UILabel!
    
    override dynamic func handleSubmitButton(sender: AnyObject) {
        
        let controller = CompletionViewController.viewControllerFromStoryboard()
        
        guard let transaction = self.transaction else {
            return
        }
        
        Container.VisitorsModel.sendVisitor(transaction: transaction) { (result) -> Void in
            
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
