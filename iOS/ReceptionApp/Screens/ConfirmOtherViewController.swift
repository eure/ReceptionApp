//
//  ConfirmOtherViewController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/27/15.
//  Copyright © 2016 eureka, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit


// MARK: - ConfirmOtherViewController

final class ConfirmOtherViewController: BaseConfirmViewController {

    
    // MARK: Internal
    
    @IBOutlet private(set) dynamic weak var companyNameView: UIView!
    @IBOutlet private(set) dynamic weak var purposeView: UIView!
    
    var transaction: OtherTransaction?
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setGradient()
        
        self.view.backgroundColor = UIColor.clearColor()
        self.companyNameView.backgroundColor = UIColor.clearColor()
        self.purposeView.backgroundColor = UIColor.clearColor()
        
        self.icons.forEach { $0.tintColor = Configuration.Color.imageTintColor }
        self.messageLabel.textColor = Configuration.Color.textColor
        self.messageLabel.font = Configuration.Font.baseBoldFont(size: 18)
        self.messageLabel.text = "ConfirmOtherViewController.label.confirm".l10n
        
        if let visitor = transaction?.visitor {
            
            self.companyNameLabel.attributedText = NSAttributedString.baseAttributedString(
                visitor.companyName,
                color: Configuration.Color.textColor,
                size: 32
            )
            if visitor.companyName.isEmpty {
                
                self.companyNameHeight.constant = 0
                self.companyNameBottom.constant = 0
            }
        }
        
        self.textView.attributedText = NSAttributedString.baseAttributedString(
            self.transaction?.visitor?.purpose ?? "",
            color: Configuration.Color.textColor,
            size: 36
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
    
    
    // MARK: Private
    
    @IBOutlet private dynamic weak var companyNameLabel: UILabel!
    @IBOutlet private dynamic weak var textView: UITextView!
    @IBOutlet private dynamic var icons: [UIImageView]!
    
    @IBOutlet private dynamic weak var companyNameHeight: NSLayoutConstraint!
    @IBOutlet private dynamic weak var companyNameBottom: NSLayoutConstraint!
}
