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
            viewTitle.text = "Detalhes da Cervejaria"
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
            let nome = "Alicate Cervejaria"
            logo.makeRoundLabel(nome)
        }
    }
    @IBOutlet weak var name: UILabel! {
        didSet {
            name.text = "Cervejaria Bar do Alicate"
            name.font = UIFont(name: "Quicksand-Bold", size: 16)
            name.textColor = UIColor(named: "BreweryBlack")
        }
    }
    @IBOutlet weak var type: UILabel! {
        didSet {
            type.text = "Bar"
            type.font = UIFont(name: "Quicksand-Regular", size: 14)
            type.textColor = UIColor(named: "BreweryBlack")
        }
    }
    @IBOutlet weak var evaluation: UILabel! {
        didSet {
            evaluation.text = "+500 avaliações"
            evaluation.font = UIFont(name: "Quicksand-Regular", size: 14)
            evaluation.textColor = UIColor(named: "BreweryBlackLight")
        }
    }
    @IBOutlet weak var average: UILabel! {
        didSet {
            average.text = "4,9"
            average.font = UIFont(name: "Quicksand-Medium", size: 14)
            average.textColor = UIColor(named: "BreweryBlack")
        }
    }
    
    @IBOutlet weak var websiteStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: websiteStackView)
        }
    }
    @IBOutlet weak var website: UILabel! {
        didSet {
            website.text = "www.cervejariaa.com.br"
            website.font = UIFont(name: "Roboto-Light", size: 14)
            website.textColor = UIColor(named: "BreweryBlack")
        }
    }
    
    @IBOutlet weak var addressStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: addressStackView)
        }
    }
    @IBOutlet weak var address: UILabel! {
        didSet {
            address.text = "618 Fifth Ave, San Diego, CA 92101, Estados Unidos"
            address.font = UIFont(name: "Roboto-Light", size: 14)
            address.textColor = UIColor(named: "BreweryBlack")
        }
    }
    
    @IBOutlet weak var mapStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: mapStackView)
        }
    }
    @IBOutlet weak var mapText: UIButton! {
        didSet {
            mapText.titleLabel?.text = "Ver no mapa"
            mapText.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14)
            mapText.titleLabel?.textColor = UIColor(named: "BreweryBlack")
            mapText.titleLabel?.underline()
        }
    }
    
    @IBOutlet weak var addPhotoButton: UIButton! {
        didSet {
            addPhotoButton.titleLabel?.text = "Adicionar Foto"
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
            evaluateBreweryButton.titleLabel?.text = "Avaliar"
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
