//
//  ContactToViewController.swift
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

import CoreStore
import RxCocoa
import RxSwift


// MARK: - ContactToViewController

final class ContactToViewController: BaseTransactionViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: Internal
    
    @IBOutlet private(set) dynamic weak var inputFieldView: UIView!
    @IBOutlet private(set) dynamic weak var tableView: UITableView!
    
    
    // MARK: UIViewController

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.view.backgroundColor = Configuration.Color.backgroundColor
        self.inputFieldView.backgroundColor = Configuration.Color.backgroundColor
        self.iconImageView.tintColor = Configuration.Color.imageTintColor
        
        self.tableViewContainerView.backgroundColor = Configuration.Color.backgroundColor
        self.tableView.rowHeight = 116
        self.tableView.backgroundColor = Configuration.Color.backgroundColor
        self.tableView.separatorColor = Configuration.Color.separatorColor
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        self.messageLabel.textColor = Configuration.Color.textColor
        self.messageLabel.font = Configuration.Font.baseBoldFont(size: 18)
        self.messageLabel.text = "ContactToViewController.label.charge".l10n
        
        self.textField.attributedPlaceholder = NSAttributedString.baseBoldAttributedString(
            "CONTACT TO...",
            color: Configuration.Color.placeholderColor,
            size: 55
        )
        
        self.textField.tintColor = Configuration.Color.textColor
        
        self.textField
            .rx_text
            .subscribeNext { [weak self] text in
                
                guard let `self` = self else {
                    
                    return
                }
                self.results = self.usersListMonitor.objectsInAllSections().filter { $0.matches(text) }
            }
            .addDisposableTo(self.disposeBag)
        
        
        self.textField
            .rx_text
            .filter { $0.characters.count > 0 }
            .subscribeNext { [weak self] _ in
                
                guard let `self` = self where !(self.textFieldTop.constant == 30) else {
                    
                    return
                }
                
                UIView.animateWithDuration(
                    0.3,
                    delay: 0,
                    options: .BeginFromCurrentState,
                    animations: { () -> Void in
                    
                        self.textFieldTop.constant = 30
                        self.messageLabel.alpha = 0
                        self.view.layoutIfNeeded()
                    },
                    completion: { _ in }
                )
            }
            .addDisposableTo(self.disposeBag)
        
        self.textField
            .rx_text
            .filter { $0.characters.count == 0 }
            .subscribeNext { [weak self] _ in
                
                guard let `self` = self where !(self.textFieldTop.constant == 100) else {
                    
                    return
                }
                
                UIView.animateWithDuration(
                    0.3,
                    delay: 0,
                    options: .BeginFromCurrentState,
                    animations: { () -> Void in
                    
                        self.textFieldTop.constant = 200
                        self.messageLabel.alpha = 1
                        self.view.layoutIfNeeded()
                    },
                    completion: { _ in }
                )
            }
            .addDisposableTo(self.disposeBag)
        
        self.tableViewMask.colors = [
            UIColor.clearColor().CGColor,
            Configuration.Color.backgroundColor.CGColor,
            Configuration.Color.backgroundColor.CGColor,
            UIColor.clearColor().CGColor,
        ]
        
        self.tableViewMask.locations = [
            0,
            0.02,
            0.98,
            1
        ]
        
        self.tableViewMask.startPoint = CGPoint(x: 0.5, y: 0)
        self.tableViewMask.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.tableViewContainerView.layer.mask = tableViewMask
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.textField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.tableViewMask.frame = self.tableViewContainerView.bounds
    }
    
    
    // MARK: UITableViewDataSource
    
    @objc dynamic func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    @objc dynamic func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.results.count
    }
    
    @objc dynamic func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithClass(ContactToSuggestCell.self, forIndexPath: indexPath)
        cell.user = self.results[indexPath.row]
        
        return cell
    }
    
    
    // MARK: UITableViewDelegate
    
    @objc dynamic func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let user = self.results[indexPath.row]
        let controller = YourNameViewController.viewControllerFromStoryboard()
        controller.contactType = .Appointment
        
        let transaction = AppointmentTransaction(user: user)
        controller.transaction = transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc dynamic func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 0)
    }
    
    
    // MARK: Private
    
    @IBOutlet private dynamic weak var tableViewContainerView: UIView!
    @IBOutlet private dynamic weak var textFieldTop: NSLayoutConstraint!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var textField: UITextField!
    @IBOutlet private dynamic weak var messageLabel: UILabel!
    
    private var results: [User] = [] {
        
        didSet {
            
            self.tableView?.reloadData()
        }
    }
    
    private let tableViewMask = CAGradientLayer()
    private let disposeBag = DisposeBag()
    
    private let usersListMonitor = CoreStore.monitorList(
        From(User),
        Where("removed == false"),
        OrderBy(.Ascending("id"))
    )
}
