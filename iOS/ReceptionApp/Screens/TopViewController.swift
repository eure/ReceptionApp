//
//  TopViewController.swift
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

import Foundation
import UIKit


// MARK: - TopViewController

final class TopViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    
    // MARK: Internal
    
    @IBOutlet private(set) dynamic weak var welcomeLabel: UILabel!
    @IBOutlet private(set) dynamic weak var welcomeBottomLabel: UILabel!
    @IBOutlet private(set) dynamic weak var otherButton: TopButton!
    @IBOutlet private(set) dynamic weak var appointButton: TopButton!
    @IBOutlet private(set) dynamic weak var longButton: UIButton!
    
    
    // MARK: UIViewController

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.logoImageView.image = Configuration.logoImage
        
        self.logoImageView.tintColor = Configuration.Color.imageTintColor
        self.welcomeLabel.textColor = Configuration.Color.textColor
        
        self.view.backgroundColor = Configuration.Color.backgroundColor
        
        self.welcomeLabel.attributedText = NSAttributedString(
            string: String.localizedStringWithFormat("TopViewController.label.selectBusiness".l10n, Configuration.companyName),
            attributes: [
                NSKernAttributeName : NSNumber(integer: 2),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 18),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
        self.welcomeBottomLabel.attributedText = NSAttributedString(
            string: "WELCOME!",
            attributes: [
                NSKernAttributeName : NSNumber(integer: 6),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 23),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
        self.appointButton.titleLabel?.attributedText = NSAttributedString(
            string: "APPOINTMENT",
            attributes: [
                NSKernAttributeName : NSNumber(integer: 6),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 23),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
        self.appointButton.subtitleLabel?.attributedText = NSAttributedString(
            string: "TopViewController.label.appointment".l10n,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 2),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 15),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
        self.otherButton.titleLabel?.attributedText = NSAttributedString(
            string: "OTHER",
            attributes: [
                NSKernAttributeName : NSNumber(integer: 6),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 23),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
        self.otherButton.subtitleLabel?.attributedText = NSAttributedString(
            string: "TopViewController.label.other".l10n,
            attributes: [
                NSKernAttributeName : NSNumber(integer: 2),
                NSFontAttributeName : Configuration.Font.baseBoldFont(size: 15),
                NSForegroundColorAttributeName : Configuration.Color.textColor,
            ]
        )
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.addTarget(self, action: "handleLongPressGesture:")
        longPressGesture.minimumPressDuration = 3
        longPressGesture.delegate = self
        self.view.addGestureRecognizer(longPressGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Container.UserService.getUsers { _ in }
    }
    
    
    // MARK: Private
    
    @IBOutlet private dynamic weak var logoImageView: UIImageView!
    
    @IBAction private dynamic func handleApointButton(sender: AnyObject) {
        
        let controller = ContactToViewController.viewControllerFromStoryboard()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func handleotherButton(sender: AnyObject) {
        
        let controller = OtherPurposeSelectViewController.viewControllerFromStoryboard()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private dynamic func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {

        let alert = UIAlertController(
            title: "",
            message: "TopViewController.alert.selectFloorNumber".l10n,
            preferredStyle: .Alert
        )
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .OrdinalStyle
        formatter.locale = NSLocale.currentLocale()
        
        Configuration.selectableFloors.enumerate().forEach { (index, floorInfo) in

            var floorName: String?
            
            if let code = NSLocale(localeIdentifier: NSBundle.mainBundle().preferredLocalizations.first!).objectForKey(NSLocaleLanguageCode) as? String {
                
                floorInfo.floorNames.forEach { (names) -> () in
                    
                    if names.0 == code {
                        floorName = names.1
                    }
                }
            }
            if floorName == nil {
                
                floorInfo.floorNames.forEach { (names) -> () in
                    
                    if names.0 == "en" {
                        floorName = names.1
                    }
                }
            }
            alert.addAction(
                UIAlertAction(
                    title: floorName,
                    style: .Default,
                    handler: { _ in
                        
                        VisitorDefaults().floor = floorInfo.floor
                    }
                )
            )
        }
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
