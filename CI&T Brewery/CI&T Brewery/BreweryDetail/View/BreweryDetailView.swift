//
//  BreweryDetailView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import UIKit

class BreweryDetailView: UIView {
    @IBOutlet weak var viewTitle: UILabel! {
        didSet {
            viewTitle.font = UIFont(name: "Roboto-Regular", size: 24)
            viewTitle.textColor = UIColor(named: "BreweryBlack")
        }
    }
    
    @IBOutlet var dataView: UIView! {
        didSet {
            dataView.layer.cornerRadius = 30
        }
    }
    
    @IBOutlet weak var logo: UILabel! {
        didSet {
            logo.makeRoundLabel()
        }
    }
    @IBOutlet weak var name: UILabel! {
        didSet {
            name.font = UIFont(name: "Quicksand-Bold", size: 16)
            name.textColor = UIColor(named: "BreweryBlack")
        }
    }
    @IBOutlet weak var type: UILabel! {
        didSet {
            type.font = UIFont(name: "Quicksand-Regular", size: 14)
            type.textColor = UIColor(named: "BreweryBlack")
        }
    }
    @IBOutlet weak var evaluation: UILabel! {
        didSet {
            evaluation.font = UIFont(name: "Quicksand-Regular", size: 14)
            evaluation.textColor = UIColor(named: "BreweryBlackLight")
        }
    }
    @IBOutlet weak var average: UILabel! {
        didSet {
            average.fontRobotoLight14ColorBreweryBlack()
        }
    }
    
    @IBOutlet weak var websiteStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: websiteStackView)
        }
    }
    @IBOutlet weak var website: UILabel! {
        didSet {
            website.fontRobotoLight14ColorBreweryBlack()
        }
    }
    
    @IBOutlet weak var addressStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: addressStackView)
        }
    }
    @IBOutlet weak var address: UILabel! {
        didSet {
            address.fontRobotoLight14ColorBreweryBlack()
        }
    }
    
    @IBOutlet weak var mapStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: mapStackView)
        }
    }
    @IBOutlet weak var mapText: UIButton! {
        didSet {
            mapText.titleLabel?.fontRobotoLight14ColorBreweryBlack()
            mapText.titleLabel?.underline()
        }
    }
    
    @IBOutlet weak var addPhotoButton: UIButton! {
        didSet {
            addPhotoButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14)
            addPhotoButton.titleLabel?.textColor = UIColor(named: "BreweryBlack")
            
            addPhotoButton.layer.borderColor = UIColor(named: "BreweryBlack")?.cgColor
            addPhotoButton.layer.borderWidth = 1
            addPhotoButton.layer.cornerRadius = 18
            
            addPhotoButton.currentImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50))
        }
    }
    @IBOutlet weak var evaluateBreweryButton: UIButton! {
        didSet {
            evaluateBreweryButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14)
            evaluateBreweryButton.titleLabel?.textColor = UIColor(named: "BreweryGold")
            
            evaluateBreweryButton.layer.borderColor = UIColor(named: "Brewery Yellow Light")?.cgColor
            evaluateBreweryButton.layer.borderWidth = 1
            evaluateBreweryButton.layer.cornerRadius = 18
            evaluateBreweryButton.layer.backgroundColor = UIColor(named: "Brewery Yellow Light")?.cgColor
        }
    }
    
    private func addBottomSeparator(uiStackView: UIStackView) {
        uiStackView.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(named: "BreweryGrayLight")!, thickness: 1.0)
    }
}
