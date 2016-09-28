//
//  ConfirmOtherPresetViewController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 9/2/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit


// MARK: ConfirmOtherPresetViewController

final class ConfirmOtherPresetViewController: BaseConfirmViewController {
    
    
    // MARK: Internal
    
    @IBOutlet private(set) weak var iconImageView: UIImageView!
    @IBOutlet private(set) weak var messageEnLabel: UILabel!
    @IBOutlet private(set) weak var messageJaLabel: UILabel!
    
    var transaction: OtherTransaction?
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = Configuration.Color.backgroundColor
        self.iconImageView.tintColor = Configuration.Color.imageTintColor
        self.messageEnLabel.attributedText = NSAttributedString(
            string: "Ready to send?",
            attributes: [
                NSKernAttributeName : NSNumber(integer: 3),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 33),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
        self.messageJaLabel.attributedText = NSAttributedString(
            string: "ConfirmOtherPresetViewController.label.confirm".l10n,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 3),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 21),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
    }
    
    
    // MARK: BaseConfirmViewController
    
    override dynamic func handleSubmitButton(sender: AnyObject) {
        
        guard let transaction = self.transaction else {
            
            return
        }
        
        super.handleSubmitButton(sender)

        let controller = CompletionViewController.viewControllerFromStoryboard()
        Container.VisitorService.sendVisitor(transaction: transaction) { _ in }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
