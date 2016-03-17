//
//  PersonCountViewController.swift
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


// MARK: - PersonCountViewController

final class PersonCountViewController: BaseTransactionViewController, InputFieldTransition {

    
    // MARK: Internal
    
    var transaction: AppointmentTransaction?
    
    
    // MARK: UIViewController

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = Configuration.Color.backgroundColor
        self.inputFieldView.backgroundColor = Configuration.Color.backgroundColor
        
        self.messageLabel.textColor = Configuration.Color.textColor
        self.messageLabel.font = Configuration.Font.baseBoldFont(size: 18)
        self.messageLabel.text = NSLocalizedString("PersonCountViewController.label.selectPersonNumber", comment: "")

        // Do any additional setup after loading the view.
        self.minusButton.tintColor = Configuration.Color.smallButtonTintColor
        self.plusButton.tintColor = Configuration.Color.smallButtonTintColor
        self.iconImageView.tintColor = Configuration.Color.imageTintColor
        
        self.count = self.transaction?.visitor?.numberOfPersons ?? 1
    }
    
    
    // MARK: InputFieldTransition
    
    @IBOutlet dynamic weak var inputFieldView: UIView!
    @IBOutlet weak var nextButton: NextButton!
    
    
    // MARK: Private
    
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

            switch NSLocale(localeIdentifier: NSBundle.mainBundle().preferredLocalizations.first!).objectForKey(NSLocaleLanguageCode) as? String ?? "" {
            case "ja":
                self.countLabel.attributedText = NSAttributedString.baseBoldAttributedString(
                    String.localizedStringWithFormat("PersonCountViewController.label.personNumber".l10n, self.count),
                    color: Configuration.Color.textColor,
                    size: 55
                )
            default:
                var countStr = ""
                if self.count == 1 {
                    countStr = String.localizedStringWithFormat("PersonCountViewController.label.personNumber".l10n, self.count)
                } else {
                    countStr = String.localizedStringWithFormat("PersonCountViewController.label.peopleNumber".l10n, self.count)
                }
                self.countLabel.attributedText = NSAttributedString.baseBoldAttributedString(
                    countStr,
                    color: Configuration.Color.textColor,
                    size: 55
                )
            }
        }
    }
    
    private var _count: Int = 1
    
    @IBOutlet private dynamic weak var countLabel: UILabel!
    @IBOutlet private dynamic weak var messageLabel: UILabel!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var minusButton: UIButton!
    @IBOutlet private dynamic weak var plusButton: UIButton!
    
    @IBAction private dynamic func handleMinusButton(sender: AnyObject) {
        
        self.count--
    }
    
    @IBAction private dynamic func handlePlusButton(sender: AnyObject) {
        
        self.count++
    }
    
    @IBAction private dynamic func handleNextButton(sender: AnyObject) {
        
        let controller = ConfirmAppointmentViewController.viewControllerFromStoryboard()
        controller.transaction = self.transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
