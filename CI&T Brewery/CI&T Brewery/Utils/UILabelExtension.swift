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
    
    public func fontRobotoRegular24ColorBreweryBlack() {
        self.font = UIFont(name: "Roboto-Regular", size: 24)
        self.textColor = UIColor(named: "BreweryBlack")
    }
    
    public func fontRobotoMedium14ColorBreweryBlack() {
        self.font = UIFont(name: "Roboto-Medium", size: 14)
        self.textColor = UIColor(named: "BreweryBlack")
    }
    
    public func fontRobotoMedium14ColorBreweryGold() {
        self.font = UIFont(name: "Roboto-Medium", size: 14)
        self.textColor = UIColor(named: "BreweryGold")
    }
    
    public func fontQuicksandRegular14ColorBreweryBlackLight() {
        self.font = UIFont(name: "Quicksand-Regular", size: 14)
        self.textColor = UIColor(named: "BreweryBlackLight")
    }
    
    public func fontQuicksandRegular14ColorBreweryBlack() {
        self.font = UIFont(name: "Quicksand-Regular", size: 14)
        self.textColor = UIColor(named: "BreweryBlack")
    }
    
    public func fontQuicksandMedium14ColorBreweryBlack() {
        self.font = UIFont(name: "Quicksand-Medium", size: 14)
        self.textColor = UIColor(named: "BreweryBlack")
    }
    
    public func fontQuicksandBold16ColorBreweryBlack() {
        self.font = UIFont(name: "Quicksand-Bold", size: 16)
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
