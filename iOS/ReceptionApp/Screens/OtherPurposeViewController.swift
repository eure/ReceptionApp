//
//  OtherPurposeViewController.swift
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

import Foundation
import UIKit

import RxCocoa
import RxSwift


// MARK: - OtherPurposeViewController

final class OtherPurposeViewController: BaseTransactionViewController, InputFieldTransition {
    
    
    // MARK: Internal
    
    var transaction: OtherTransaction?
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = Configuration.Color.backgroundColor
        self.inputFieldView.backgroundColor = Configuration.Color.backgroundColor
        self.textViewContainerView.backgroundColor = Configuration.Color.backgroundColor
        
        self.textView.font = Configuration.Font.baseFont(size: 55)
        self.messageLabel.font = Configuration.Font.baseBoldFont(size: 18)
        self.messageLabel.textColor = Configuration.Color.textColor
        self.messageLabel.text = "OtherPurposeViewController.label.business".l10n
        self.iconImageView.tintColor = Configuration.Color.textColor
        self.textView.tintColor = Configuration.Color.textColor
        self.textView.textColor = Configuration.Color.textColor
        
        self.textView.text = self.transaction?.visitor?.purpose
        
        self.textViewMask.colors = [
            UIColor.clearColor().CGColor,
            Configuration.Color.backgroundColor.CGColor,
            Configuration.Color.backgroundColor.CGColor,
            UIColor.clearColor().CGColor,
        ]
        self.textViewMask.locations = [
            0,
            0.02,
            0.98,
            1
        ]
        
        self.textViewMask.startPoint = CGPoint(x: 0.5, y: 0)
        self.textViewMask.endPoint = CGPoint(x: 0.5, y: 1)
        self.textViewContainerView.layer.mask = textViewMask
        
        self.nextButton.enabled = false
        
        self.textView
            .rx_text
            .map { $0.characters.count }
            .subscribeNext { [weak self] count in
                
                self?.textViewPlaceHolder.hidden = count > 0
                self?.nextButton.enabled = count > 0
            }
            .addDisposableTo(self.disposeBag)
        
        self.textViewPlaceHolder.attributedText = NSAttributedString(
            string: "REASON FOR VISIT",
            attributes: [
                NSKernAttributeName : NSNumber(integer: 6),
                NSFontAttributeName :  Configuration.Font.baseBoldFont(size: 55),
                NSForegroundColorAttributeName : Configuration.Color.placeholderColor,
            ]
        )
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.textViewMask.frame = self.textViewContainerView.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textView.becomeFirstResponder()
    }
    
    
    // MARK: InputFieldTransition
    
    @IBOutlet private(set) dynamic weak var inputFieldView: UIView!
    @IBOutlet private(set) dynamic weak var nextButton: NextButton!
    
    
    // MARK: Private
    
    @IBOutlet private dynamic weak var textViewPlaceHolder: UILabel!
    @IBOutlet private dynamic weak var messageLabel: UILabel!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var textViewContainerView: UIView!
    @IBOutlet private dynamic weak var textView: UITextView!
    
    private let textViewMask = CAGradientLayer()
    private let disposeBag = DisposeBag()
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        guard let purpose = self.textView.text else {
            
            return
        }
        
        let controller = ConfirmOtherViewController.viewControllerFromStoryboard()
        self.transaction?.visitor?.purpose = purpose
        controller.transaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
