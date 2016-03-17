//
//  YourNameViewController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/23/15.
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

import RxCocoa
import RxSwift


// MARK: - YourNameViewController

final class YourNameViewController: BaseTransactionViewController, InputFieldTransition {

    
    // MARK: Internal
    
    var transaction: AppointmentTransaction?
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = Configuration.Color.backgroundColor
        self.inputFieldView.backgroundColor = Configuration.Color.backgroundColor
        
        self.messageLabel.textColor = Configuration.Color.textColor
        self.messageLabel.font = Configuration.Font.baseBoldFont(size: 18)
        self.messageLabel.text = "YourNameViewController.label.name".l10n
        
        self.textField.attributedPlaceholder = NSAttributedString.baseBoldAttributedString(
            "YOUR NAME",
            color: Configuration.Color.placeholderColor,
            size: 55
        )
        self.textField.textColor = Configuration.Color.textColor
        self.textField.tintColor = Configuration.Color.textColor
        self.textField.text = self.transaction?.visitor?.name
                
        self.iconImageView.tintColor = Configuration.Color.imageTintColor
        
        self.nextButton.enabled = false
                
        self.textField
            .rx_text
            .subscribeNext { [weak self] text in
                
                let result = text.characters.count > 0
                self?.nextButton.enabled = result
            }
            .addDisposableTo(self.disposeBag)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    
    // MARK: InputFieldTransition
    
    @IBOutlet private(set) dynamic weak var inputFieldView: UIView!
    @IBOutlet private(set) dynamic weak var nextButton: NextButton!
    
    
    // MARK: Private
    
    @IBOutlet private dynamic weak var textField: UITextField!
    @IBOutlet private dynamic weak var messageLabel: UILabel!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    
    private let disposeBag = DisposeBag()
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        let controller = CompanyNameViewController.viewControllerFromStoryboard()
        
        guard let name = self.textField.text where !name.isEmpty else {
            
            return
        }
        
        var visitor = self.transaction?.visitor ?? AppointmentVisitor()
        visitor.name = name
        self.transaction?.visitor = visitor
        controller.appointmentTransaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
