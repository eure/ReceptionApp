//
//  ContactsSuggestionViewController.swift
//  Reception
//
//  Created by Muukii on 8/11/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class AccountsSuggestViewController: UIViewController {
    
    var candidate: String = "" {
        didSet {
            
            results = AppConfiguration.allEmployees.filter { $0.compare(candidate) == true }
            JEDump(results)
        }
    }
    
    var didSelectAccount: ((account: Account) -> Void)?
    
    @IBOutlet private dynamic weak var tableView: UITableView!
    
    private var results: [Account] = [] {
        didSet {
            
            self.tableView?.reloadData()
        }
    }
}

extension AccountsSuggestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithClass(SuggestedAccountCell.self, forIndexPath: indexPath)
        cell.account = self.results[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let account = self.results[indexPath.row]
        self.didSelectAccount?(account: account)
    }    
}
