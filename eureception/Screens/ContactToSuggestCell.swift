//
//  ContactToSuggestCell.swift
//  Reception
//
//  Created by Muukii on 8/24/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class ContactToSuggestCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.eureColor
        self.iconImageView.tintColor = UIColor.eureLightGrayTextColor
        
        self.nameJaLabel.font = UIFont.eureFont(size: 55)
        self.nameJaLabel.textColor = UIColor.whiteColor()
        self.nameEnLabel.textColor = UIColor.whiteColor()
                        
        let selectedView = UIView(frame: self.bounds)
        selectedView.backgroundColor = UIColor.eureLightEureColor
        self.selectedBackgroundView = selectedView
        self.layer.cornerRadius = 20
    }

    var user: User? {
        didSet {
            self.nameJaLabel.text = self.user?.nameJa
            self.nameEnLabel.attributedText = NSAttributedString.eureAttributedString(self.user?.nameEn ?? "", color: UIColor.whiteColor(), size: 16 )
        }
    }
    
    @IBOutlet private dynamic weak var nameJaLabel: UILabel!
    @IBOutlet private dynamic weak var nameEnLabel: UILabel!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!

}
