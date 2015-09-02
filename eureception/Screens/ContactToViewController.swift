//
//  ContactToViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import CoreStore
import RxCocoa
import RxSwift

class ContactToViewController: BaseTransactionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.iconImageView.tintColor = UIColor.eureColor
        self.tableView.rowHeight = 116
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        self.messageLabel.textColor = UIColor.eureColor
        self.messageLabel.font = UIFont.eureBoldFont(size: 18)
        self.messageLabel.text = "弊社担当者をご記入ください"
        
        self.textField.attributedPlaceholder = NSAttributedString.eureBoldAttributedString(
            "CONTACT TO...",
            color: UIColor.eureLightGrayTextColor,
            size: 55
        )
        
        self.textField.tintColor = UIColor.eureColor
        
        // Do any additional setup after loading the view.
        
        self.textField
            .rx_text
            .subscribe { [weak self] event in
                
                guard let value = event.value else {
                    return
                }
                JEDump(self?.usersListMonitor.objectsInAllSections())
                self?.results = self?.usersListMonitor.objectsInAllSections().filter { $0.compare(value) == true } ?? []
        }
        
        self.textField
            .rx_text
            .filter { $0.characters.count > 0 }
            .subscribe { [weak self] event in
                
                guard !(self?.textFieldTop.constant == 30) else {
                    return
                }
                
                UIView.animateWithDuration(0.3, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                    
                    self?.textFieldTop.constant = 30
                    self?.messageLabel.alpha = 0
                    self?.view.layoutIfNeeded()
                    }, completion: { (finish) -> Void in
                })
        }
        
        self.textField
            .rx_text
            .filter { $0.characters.count == 0 }
            .subscribe { [weak self] event in
                
                guard !(self?.textFieldTop.constant == 100) else {
                    return
                }
                
                UIView.animateWithDuration(0.3, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                    
                    self?.textFieldTop.constant = 200
                    self?.messageLabel.alpha = 1
                    self?.view.layoutIfNeeded()
                    }, completion: { (finish) -> Void in
                })
        }                     
        
        self.tableViewMask.colors = [
            UIColor.clearColor().CGColor,
            UIColor.whiteColor().CGColor,
            UIColor.whiteColor().CGColor,
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
    
    @IBOutlet dynamic weak var inputFieldView: UIView!
    @IBOutlet dynamic weak var tableViewContainerView: UIView!
    @IBOutlet dynamic weak var tableView: UITableView!
    
    // MARK: Private
    @IBOutlet private dynamic weak var textFieldTop: NSLayoutConstraint!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var textField: UITextField!
    @IBOutlet private dynamic weak var messageLabel: UILabel!
    private let tableViewMask = CAGradientLayer()
    
    private var results: [User] = [] {
        didSet {
            
            self.tableView?.reloadData()
        }
    }
    
    private let usersListMonitor = CoreStore.monitorList(From(User), Where("removed == false"), OrderBy(.Ascending("id")))
}

extension ContactToViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithClass(ContactToSuggestCell.self, forIndexPath: indexPath)
        cell.user = self.results[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let user = self.results[indexPath.row]
        
        let controller = YourNameViewController.viewControllerFromStoryboard()

        let transaction = AppointmentTransaction(user: user)
        controller.transaction = transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 0)
    }
}
