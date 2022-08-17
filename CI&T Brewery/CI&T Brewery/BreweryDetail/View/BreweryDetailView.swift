//
//  BreweryDetailView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import UIKit

class BreweryDetailView: UIView {
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
    @IBOutlet weak var logo2: UIImageView!
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
            evaluation.text = "+500 visualizações"
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
    
    @IBOutlet weak var website: UILabel! {
        didSet {
            website.text = "www.cervejariaa.com.br"
            website.font = UIFont(name: "Roboto-Light", size: 14)
            website.textColor = UIColor(named: "BreweryBlack")
        }
    }
    @IBOutlet weak var address: UILabel! {
        didSet {
            address.text = "618 Fifth Ave, San Diego, CA 92101, Estados Unidos"
            address.font = UIFont(name: "Roboto-Light", size: 14)
            address.textColor = UIColor(named: "BreweryBlack")
        }
    }
}
