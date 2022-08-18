//
//  UIFontExtension.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 18/08/22.
//

import UIKit

struct AppFontName {
    static let robotoLight = "Roboto-Light"
    static let robotoMedium = "Roboto-Medium"
    static let robotoRegular = "Roboto-Regular"
    static let quicksandBold = "Quicksand-Bold"
    static let quicksandRegular = "Quicksand-Regular"
    static let quicksandMedium = "Quicksand-Medium"
}

extension UIFont {
    class func robotoLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.robotoLight, size: size)!
    }
    
    class func robotoMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.robotoMedium, size: size)!
    }
    
    class func robotoRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.robotoRegular, size: size)!
    }
    
    class func quicksandBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.quicksandBold, size: size)!
    }
    
    class func quicksandRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.quicksandRegular, size: size)!
    }
    
    class func quicksandMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.quicksandMedium, size: size)!
    }
}
