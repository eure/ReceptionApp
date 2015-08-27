//
//  ConfirmOtherViewController.swift
//  eureception
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class ConfirmOtherViewController: BaseConfirmViewController {

    var transaction: OtherTransaction?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.iconImageView.tintColor = UIColor.eureColor
        // Do any additional setup after loading the view.
        
        self.textView.attributedText = NSAttributedString.eureAttributedString(self.transaction?.purpose ?? "", color: UIColor.eureBlackTextColor, size: 36)
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override dynamic func handleSubmitButton(sender: AnyObject) {
        
        let controller = CompletionViewController.viewControllerFromStoryboard()
        
        guard let transaction = self.transaction else {
            return
        }
        SlackDispatcher.call(transaction)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
