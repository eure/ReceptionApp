//
//  TopViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit

class TopViewController: BaseViewController , UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.logoImageView.tintColor = UIColor.whiteColor()
        self.welcomeLabel.textColor = UIColor.whiteColor()
        
        self.view.backgroundColor = UIColor.eureColor
        
        self.welcomeLabel.attributedText = NSAttributedString(string: "ようこそeurekaへ ご用件をお選びください", attributes: [
            NSKernAttributeName : NSNumber(integer: 2),
            NSFontAttributeName : UIFont.eureBoldFont(size: 18),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        
        self.welcomeBottomLabel.attributedText = NSAttributedString(string: "WELCOME!", attributes: [
            NSKernAttributeName : NSNumber(integer: 6),
            NSFontAttributeName : UIFont.eureBoldFont(size: 23),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        
        self.appointButton.titleLabel?.attributedText = NSAttributedString(string: "APPOINTMENT", attributes: [
            NSKernAttributeName : NSNumber(integer: 6),
            NSFontAttributeName : UIFont.eureBoldFont(size: 23),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        
        self.appointButton.subtitleLabel?.attributedText = NSAttributedString(string: "ご予約のある方はこちら", attributes: [
            NSKernAttributeName : NSNumber(integer: 2),
            NSFontAttributeName : UIFont.eureBoldFont(size: 15),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        self.otherButton.titleLabel?.attributedText = NSAttributedString(string: "OTHER", attributes: [
            NSKernAttributeName : NSNumber(integer: 6),
            NSFontAttributeName : UIFont.eureBoldFont(size: 23),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        self.otherButton.subtitleLabel?.attributedText = NSAttributedString(string: "その他ご用件の方はこちら", attributes: [
            NSKernAttributeName : NSNumber(integer: 2),
            NSFontAttributeName : UIFont.eureBoldFont(size: 15),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            ]
        )
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.addTarget(self, action: "handleLongPressGesture:")
        longPressGesture.minimumPressDuration = 3
        longPressGesture.delegate = self
        self.longButton.addGestureRecognizer(longPressGesture)        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Container.UserService.getUsers { (result) -> Void in
            switch result {
            case .Success(let user):
                break
            case .Failure(let errorType):
                break
            }
        }
    }
    
    @IBOutlet dynamic weak var welcomeLabel: UILabel!
    @IBOutlet dynamic weak var welcomeBottomLabel: UILabel!
    @IBOutlet dynamic weak var otherButton: TopButton!
    @IBOutlet dynamic weak var appointButton: TopButton!
    @IBOutlet weak var longButton: UIButton!
    
    // MARK: Private
    @IBOutlet private dynamic weak var logoImageView: UIImageView!
    
    @IBAction func handleApointButton(sender: AnyObject) {
        
        let controller = ContactToViewController.viewControllerFromStoryboard()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func handleotherButton(sender: AnyObject) {
        
        let controller = OtherPurposeSelectViewController.viewControllerFromStoryboard()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private dynamic func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {

        let alert = UIAlertController(title: "", message: "階を選択してください", preferredStyle: .Alert)
        alert.addAction(
            UIAlertAction(
                title: "5階",
                style: .Default,
                handler: { (_) -> Void in
                    
                    VisitorDefaults().floor = 5
                }
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "6階",
                style: .Default,
                handler: { (_) -> Void in
                    
                    VisitorDefaults().floor = 6
                }
            )
        )
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
