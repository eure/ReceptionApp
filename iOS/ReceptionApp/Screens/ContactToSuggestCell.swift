//
//  ContactToSuggestCell.swift
//  ReceptionApp
//
//  Created by Hiroshi Kimura on 8/24/15.
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

// MARK: - ContactToSuggestCell

final class ContactToSuggestCell: UITableViewCell {
    
    
    // MARK: Internal
    
    var user: User? {
        
        didSet {
            
            self.nameJaLabel.text = self.user?.nameJa
            self.nameEnLabel.attributedText = NSAttributedString.baseAttributedString(
                self.user?.nameEn ?? "",
                color: Configuration.Color.textColor,
                size: 16
            )
        }
    }
    
    // MARK: NSObject

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.backgroundColor = Configuration.Color.backgroundColor
        self.iconImageView.tintColor = Configuration.Color.imageTintColor
        
        self.nameJaLabel.font = Configuration.Font.baseFont(size: 55)
        self.nameJaLabel.textColor = Configuration.Color.textColor
        self.nameEnLabel.textColor = Configuration.Color.textColor
                        
        let selectedView = UIView(frame: self.bounds)
        selectedView.backgroundColor = Configuration.Color.highlightedCellColor
        self.selectedBackgroundView = selectedView
        self.layer.cornerRadius = 20
    }
    
    
    // MARK: Private
    
    @IBOutlet private dynamic weak var nameJaLabel: UILabel!
    @IBOutlet private dynamic weak var nameEnLabel: UILabel!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
}
