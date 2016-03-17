//
//  CompletionViewController.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/25/15.
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

import AudioToolbox
import UIKit

import GCDKit

// MARK: - CompletionViewController

final class CompletionViewController: BaseViewController {
    
    // MARK: Internal
    
    @IBOutlet private(set) dynamic weak var iconImageView: UIImageView!
    @IBOutlet private(set) dynamic weak var titleLabel: UILabel!
    @IBOutlet private(set) dynamic weak var subtitleLabel: UILabel!
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.iconImageView.tintColor = Configuration.Color.completionViewTextColor
        
        self.titleLabel.attributedText = NSAttributedString(
            string: "THANK YOU!",
            attributes: [
                NSKernAttributeName : NSNumber(integer: 8),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 36),
                NSForegroundColorAttributeName : Configuration.Color.completionViewTextColor,
            ]
        )
        self.subtitleLabel.attributedText = NSAttributedString(
            string: "CompletionViewController.label.completion".l10n,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 2),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 22),
                NSForegroundColorAttributeName : Configuration.Color.completionViewTextColor,
            ]
        )
        
        GCDQueue.Main.after(10) { [weak self] in
            
            self?.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
    // MARK: Private
    
    private var transaction: AppointmentTransaction?
    
    @IBAction private dynamic func handleHomeButton(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }    
}
