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
            viewTitle.fontRobotoRegular24ColorBreweryBlack()
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
            name.fontQuicksandBold16ColorBreweryBlack()
        }
    }
    @IBOutlet weak var type: UILabel! {
        didSet {
            type.fontQuicksandRegular14ColorBreweryBlack()
        }
    }
    @IBOutlet weak var evaluation: UILabel! {
        didSet {
            evaluation.fontQuicksandRegular14ColorBreweryBlackLight()
        }
    }
    @IBOutlet weak var average: UILabel! {
        didSet {
            average.fontQuicksandMedium14ColorBreweryBlack()
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
            mapText.titleLabel?.fontRobotoMedium14ColorBreweryBlack()
            mapText.titleLabel?.underline()
            
            // alinha o texto completamente a esquerda
            mapText.titleLabel?.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                mapText.titleLabel!.leadingAnchor.constraint(equalTo: mapText.leadingAnchor),
                mapText.titleLabel!.trailingAnchor.constraint(equalTo: mapText.trailingAnchor),
                mapText.titleLabel!.topAnchor.constraint(equalTo: mapText.topAnchor),
                mapText.titleLabel!.bottomAnchor.constraint(equalTo: mapText.bottomAnchor)
            ])
        }
    }
    
    @IBOutlet weak var addPhotoButton: UIButton! {
        didSet {
            addPhotoButton.layer.borderColor = UIColor(named: "BreweryBlack")?.cgColor
            addPhotoButton.layer.borderWidth = 1
            addPhotoButton.layer.cornerRadius = 18
            
//            addPhotoButton.tintColor = UIColor(named: "BreweryBlack")
//            addPhotoButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14)
            
            addPhotoButton.titleLabel?.fontRobotoMedium14ColorBreweryBlack()
            
//            guard var config = addPhotoButton.configuration else {
//                return
//            }
//            config.buttonSize = .medium
//            
//            addPhotoButton.configuration = config
        }
    }
    @IBOutlet weak var evaluateBreweryButton: UIButton! {
        didSet {
            evaluateBreweryButton.titleLabel?.fontRobotoMedium14ColorBreweryGold()
            
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
