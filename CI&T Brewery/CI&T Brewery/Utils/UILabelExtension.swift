//
//  UIFontExtension.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 17/08/22.
//

import UIKit

extension UILabel {
    public func fontRobotoLight14ColorBreweryBlack() {
        self.font = UIFont(name: "Roboto-Light", size: 14)
        self.textColor = UIColor(named: "BreweryBlack")
    }
    
    public func makeRoundLabel()  {
        self.textColor = UIColor(named: "BreweryYellow")
        self.backgroundColor = UIColor(named: "Brewery Yellow Alpha 16")
        self.font = UIFont(name: "Roboto-Medium", size: 32)
        self.textAlignment = .center
        self.layer.masksToBounds = true
        self.layer.cornerRadius = (self.frame.width / 2)
        self.isEnabled = true
    }
    
    public func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.attributedText = attributedString
        }
    }
}
