//
//  UIColorExtension.swift
//  CIandTMovieDatabase
//
//  Created by Rafaela Cristina Souza dos Santos on 02/08/22.
//

import Foundation
import UIKit

struct AppColorName {
    static let backgroundColor = "Background Home"
    static let breweryYellowAlpha16 = "Brewery Yellow Alpha 16"
    static let breweryYellowLight = "Brewery Yellow Light"
    static let breweryBlack = "BreweryBlack"
    static let breweryBlackLight = "BreweryBlackLight"
    static let breweryGold = "BreweryGold"
    static let breweryGrayLight = "BreweryGrayLight"
    static let breweryYellow = "BreweryYellow"
    static let grayLighter = "GrayLighter"
    static let outlineGreen = "OutlineGreen"
    static let outlineBlack = "OutlineBlack"
    static let outlineRed = "OutlineRed"
    static let BreweryYellowPale = "BreweryYellowPale"
}

extension UIColor {
    class func backgroundColor() -> UIColor { UIColor(named: AppColorName.backgroundColor)! }
    class func breweryYellowAlpha16() -> UIColor { UIColor(named: AppColorName.breweryYellowAlpha16)! }
    class func breweryYellowLight() -> UIColor { UIColor(named: AppColorName.breweryYellowLight)! }
    class func breweryBlack() -> UIColor { UIColor(named: AppColorName.breweryBlack)! }
    class func breweryBlackLight() -> UIColor { UIColor(named: AppColorName.breweryBlackLight)! }
    class func breweryGold() -> UIColor { UIColor(named: AppColorName.breweryGold)! }
    class func breweryGrayLight() -> UIColor { UIColor(named: AppColorName.breweryGrayLight)! }
    class func breweryYellow() -> UIColor { UIColor(named: AppColorName.breweryYellow)! }
    class func grayLighter() -> UIColor { UIColor(named: AppColorName.grayLighter)! }
    class func outlineGreen() -> UIColor { UIColor(named: AppColorName.outlineGreen)! }
    class func outlineBlack() -> UIColor { UIColor(named: AppColorName.outlineBlack)! }
    class func outlineRed() -> UIColor { UIColor(named: AppColorName.outlineRed)! }
    class func BreweryYellowPale() -> UIColor { UIColor(named: AppColorName.BreweryYellowPale)! }
}
