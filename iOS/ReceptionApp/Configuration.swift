//
//  Configuration.swift
//  ReceptionApp
//
//  Created by Kazuki Yusa on 2016/02/12.
//  Copyright © 2016年 eureka, Inc. All rights reserved.
//

import UIKit

enum Configuration {

    // MARK: Internal
    
    struct Color {
        
        static let backgroundColor = baseColor
        static let textColor = textBaseColor
        static let placeholderColor = subColor
        static let separatorColor = subColor
        static let imageTintColor = textBaseColor
        static let highlightedCellColor = subColor
        static let backgroundGradientColor = gradientColor
        // Large Button
        static let largeButtonTintColor = textBaseColor
        static let largeButtonBackgroundColor = baseColor
        static let largeButtonBorderColor = subColor
        // Small Button
        static let smallButtonTintColor = textBaseColor
        static let smallButtonBackgroundColor = baseColor
        static let smallButtonBorderColor = textBaseColor
        // Completion View
        static let completionViewBackgroundColor = textBaseColor
        static let completionViewTextColor = baseColor
        // Completion View Button
        static let completionViewButtonTintColor = baseColor
        static let completionViewButtonBackgroundColor = textBaseColor
        static let completionViewButtonBorderColor = baseColor
    }
    
    struct Font {
        
        static func baseBoldFont(size size: CGFloat) -> UIFont {
            
            let descriptor = UIFontDescriptor(
                fontAttributes: [
                    UIFontDescriptorNameAttribute: Configuration.baseBoldFont,
                    UIFontDescriptorCascadeListAttribute : [
                        UIFontDescriptor(
                            fontAttributes: [UIFontDescriptorNameAttribute: baseBoldCascadeFont]
                        ),
                        UIFont.systemFontOfSize(size).fontDescriptor()
                    ]
                ]
            )
            return UIFont(descriptor: descriptor, size: size)
        }
        
        static func baseFont(size size: CGFloat) -> UIFont {
            
            let descriptor = UIFontDescriptor(
                fontAttributes: [
                    UIFontDescriptorNameAttribute: Configuration.baseFont,
                    UIFontDescriptorCascadeListAttribute : [
                        UIFontDescriptor(
                            fontAttributes: [UIFontDescriptorNameAttribute: baseCascadeFont]
                        ),
                        UIFont.systemFontOfSize(size).fontDescriptor()
                    ]
                ]
            )
            return UIFont(descriptor: descriptor, size: size)
        }
        
        static func topBoldFont(size size: CGFloat) -> UIFont {
            
            let descriptor = UIFontDescriptor(
                fontAttributes: [
                    UIFontDescriptorNameAttribute: Configuration.topBoldFont,
                    UIFontDescriptorCascadeListAttribute : [
                        UIFontDescriptor(
                            fontAttributes: [UIFontDescriptorNameAttribute: baseBoldCascadeFont]
                        ),
                        UIFont.systemFontOfSize(size).fontDescriptor()
                    ]
                ]
            )
            return UIFont(descriptor: descriptor, size: size)
        }
    }
    
    // Company Name
    static let companyName = "eureka"
    
    // Logo Image 147 × 30
    static let logoImage = UIImage(named: "eureka_logo")
    
    // Welcome Image
    static let welcomeImage = UIImage(named: "image_logo")

    // Sent Sound
    static var sentSoundPath: String? = NSBundle.mainBundle().pathForResource("send_sound", ofType: "mp3")
    
    // Floor
    typealias FloorInfo = (floor: Int, floorNames: [String:String])
    
    static let selectableFloors: [FloorInfo] = [
        (floor: 5, floorNames: ["ja":"5階", "en":"5th floor"]),
        (floor: 6, floorNames: ["ja":"6階", "en":"6th floor"]),
    ]
    
    // Token
    struct Token {
        
        static let baseUrl = "https://reception.eure.jp/api/v1"
        static let APIKey = "O4mug2zIiuNcfd0WKMYN0Nz4EnrPa5"
    }
    
    // Color
    private static let baseColor = UIColor(int: 0xc6cb31, alpha: 1)
    private static let subColor = UIColor(white: 1, alpha: 0.4)
    private static let textBaseColor = UIColor.whiteColor()
    private static let gradientColor = UIColor(int: 0x9ee04d, alpha: 1)
    
    // Font
    private static let baseBoldFont = "Exo-Bold"
    private static let baseBoldCascadeFont = "KozGoPro-Medium"
    private static let baseFont = "Exo-Bold"
    private static let baseCascadeFont = "KozGoPro-Regular"
    private static let topBoldFont = "Exo-ExtraBold"
}
