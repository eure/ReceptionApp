//
//  SuggestedAccountCell.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/18/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Foundation
import UIKit

class SuggestedAccountCell: UITableViewCell {
    
    var account: Account? {
        didSet {
            
            guard let account = self.account else {
                return
            }
            
            self.nameLabel.text = account.nameJa + " - " + account.nameEn
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
}
