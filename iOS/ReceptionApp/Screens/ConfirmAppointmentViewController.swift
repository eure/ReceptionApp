//
//  ConfirmViewController.swift
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

import UIKit


// MARK: - ConfirmAppointmentViewController

final class ConfirmAppointmentViewController: BaseConfirmViewController {
    

    // MARK: Internal
    
    @IBOutlet private(set) dynamic weak var contactToView: UIView!
    @IBOutlet private(set) dynamic weak var nameView: UIView!
    @IBOutlet private(set) dynamic weak var companyNameView: UIView!
    @IBOutlet private(set) dynamic weak var countview: UIView!
    
    var transaction: AppointmentTransaction?
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = Configuration.Color.backgroundColor
        self.contactToView.backgroundColor = Configuration.Color.backgroundColor
        self.nameView.backgroundColor = Configuration.Color.backgroundColor
        self.companyNameView.backgroundColor = Configuration.Color.backgroundColor
        self.countview.backgroundColor = Configuration.Color.backgroundColor
        
        self.icons.forEach { $0.tintColor = Configuration.Color.imageTintColor }
        
        self.contactToLabel.attributedText = NSAttributedString.baseAttributedString(
            self.transaction?.user.nameJa ?? "",
            color: Configuration.Color.textColor,
            size: 32
        )
        
        if let visitor = self.transaction?.visitor {
            
            let size: CGFloat = 32
            self.nameLabel.attributedText = NSAttributedString.baseAttributedString(
                visitor.name ?? "",
                color: Configuration.Color.textColor,
                size: size
            )
            self.companyLabel.attributedText = NSAttributedString.baseAttributedString(
                visitor.companyName,
                color: Configuration.Color.textColor,
                size: size
            )
            self.countLabel.attributedText = NSAttributedString.baseAttributedString(
                "\(visitor.numberOfPersons)人",
                color: Configuration.Color.textColor,
                size: size
            )
        }
        
        self.messageLabel.font = Configuration.Font.baseBoldFont(size: 18)
        self.messageLabel.text = "ConfirmAppointmentViewController.label.confirm".l10n
        self.messageLabel.textColor = Configuration.Color.textColor
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
    
    @IBOutlet private dynamic weak var contactToIconImageView: UIImageView!
    @IBOutlet private dynamic weak var nameIconImageView: UIImageView!
    @IBOutlet private dynamic weak var companyNameIconImageView: UIImageView!
    @IBOutlet private dynamic weak var countIconImageView: UIImageView!
    
    @IBOutlet private dynamic weak var contactToLabel: UILabel!
    @IBOutlet private dynamic weak var nameLabel: UILabel!
    @IBOutlet private dynamic weak var companyLabel: UILabel!
    @IBOutlet private dynamic weak var countLabel: UILabel!
    
    @IBOutlet private dynamic var icons: [UIImageView]!
    @IBOutlet private dynamic var labels: [UILabel]!
}
