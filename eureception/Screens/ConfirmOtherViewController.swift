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
        
        self.iconImageView.tintColor = UIColor.eureLightGrayTextColor
        self.messageLabel.textColor = UIColor.eureColor
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.messageLabel.text = "以下、内容をご確認ください"
        
        self.textView.attributedText = NSAttributedString.eureAttributedString(self.transaction?.visitor.purpose ?? "", color: UIColor.eureBlackTextColor, size: 36)
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var purposeView: UIView!
    
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
