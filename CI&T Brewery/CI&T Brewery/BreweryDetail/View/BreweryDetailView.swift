//
//  BreweryDetailView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import UIKit
import Cosmos

class BreweryDetailView: UIView {
    
    @IBOutlet weak var viewTitle: UILabel! {
        didSet {
            viewTitle.font = UIFont.robotoRegular(ofSize: 24)
            viewTitle.textColor = UIColor.breweryBlack()
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
            name.font = UIFont.quicksandBold(ofSize: 16)
            name.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var type: UILabel! {
        didSet {
            type.font = UIFont.quicksandRegular(ofSize: 14)
            type.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var evaluation: UILabel! {
        didSet {
            evaluation.font = UIFont.quicksandRegular(ofSize: 14)
            evaluation.textColor = UIColor.breweryBlackLight()
        }
    }
    @IBOutlet weak var average: UILabel! {
        didSet {
            average.font = UIFont.quicksandMedium(ofSize: 14)
            average.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var cosmosView: CosmosView!
    
    @IBOutlet weak var websiteStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: websiteStackView)
        }
    }
    @IBOutlet weak var website: UILabel! {
        didSet {
            website.font = UIFont.robotoLight(ofSize: 14)
            website.textColor = UIColor.breweryBlack()
        }
    }
    
    @IBOutlet weak var addressStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: addressStackView)
        }
    }
    @IBOutlet weak var address: UILabel! {
        didSet {
            address.font = UIFont.robotoLight(ofSize: 14)
            address.textColor = UIColor.breweryBlack()

        }
    }
    
    @IBOutlet weak var mapStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: mapStackView)
        }
    }
    @IBOutlet weak var mapText: UIButton! {
        didSet {
            let attrs = [
                NSAttributedString.Key.font: UIFont.robotoMedium(ofSize: 14),
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.foregroundColor: UIColor.breweryBlack()
            ] as [NSAttributedString.Key : Any]
            let attrString = NSMutableAttributedString(string: NSLocalizedString("seeOnMap", comment: ""), attributes:attrs)
            mapText.setAttributedTitle(attrString, for: .normal)
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
            addPhotoButton.layer.borderColor = UIColor.breweryBlack().cgColor
            addPhotoButton.layer.borderWidth = 1
            addPhotoButton.layer.cornerRadius = 18
        }
    }
    @IBOutlet weak var evaluateBreweryButton: UIButton! {
        didSet {
            evaluateBreweryButton!.layer.borderColor = UIColor.breweryYellowLight().cgColor
            evaluateBreweryButton!.layer.borderWidth = 1
            evaluateBreweryButton!.layer.cornerRadius = 18
            evaluateBreweryButton!.layer.backgroundColor = UIColor.breweryYellowLight().cgColor
        }
    }
        
    @IBAction func fadeButtonTouchDown(sender: UIButton) {
        sender.isHighlighted = false
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: [.curveLinear,
                      .allowUserInteraction,
                      .beginFromCurrentState],
            animations: {
            sender.alpha = 0.75
        }, completion: nil)
    }

    @IBAction func fadeButtonTouchUpInside(sender: UIButton) {
        sender.isHighlighted = false
        sender.alpha = 1
    }
    
    private func addBottomSeparator(uiStackView: UIStackView) {
        uiStackView.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.breweryGrayLight(), thickness: 1.0)
    }
    
    func configure(_ brewery: BreweryObject) {
        name.text = brewery.name
        logo.text = brewery.logo
        type.text = brewery.type
        evaluation.text = String(brewery.evaluation)
        average.text = String(brewery.average)
        website.text = brewery.website
        address.text = brewery.address
        cosmosView.rating = brewery.average
        
        if (brewery.latitute == 0 && brewery.longitude == 0) {
            mapStackView.isHidden = true
            addPhotoButton.topAnchor.constraint(equalTo: addressStackView.bottomAnchor, constant: 15).isActive = true
            dataView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        }
    }
}
