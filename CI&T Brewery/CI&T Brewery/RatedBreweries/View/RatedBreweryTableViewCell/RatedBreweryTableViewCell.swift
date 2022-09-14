//
//  RatedBreweryTableViewCell.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 14/09/22.
//

import Foundation
import UIKit
import Cosmos

class RatedBreweryTableViewCell: UITableViewCell{
	
	@IBOutlet weak var mainView: UIView!{
		didSet{
			mainView.layer.cornerRadius = 30
		}
	}
	@IBOutlet weak var lbProfileLetter: UILabel!{
		didSet{
			lbProfileLetter.makeRoundLabel()
		}
	}
	@IBOutlet weak var lbBrewery: UILabel!{
		didSet{
			lbBrewery.font = UIFont.robotoRegular(ofSize: 16)
			lbBrewery.textColor = UIColor.breweryBlack()
		}
	}
	@IBOutlet weak var lbBreweryAverage: UILabel!{
		didSet{
			lbBreweryAverage.font = UIFont.robotoLight(ofSize: 14)
			lbBreweryAverage.textColor = UIColor.breweryBlack()
		}
	}
	@IBOutlet weak var cosmosView: CosmosView!
	
	func configure(_ cell: RatedBreweryTableViewCell, for brewery: Brewery) {
		lbProfileLetter.text = String(brewery.name[brewery.name.startIndex])
		lbBrewery.text = brewery.name
		lbBreweryAverage.text = String(format: "%.f", brewery.average)
		cosmosView.rating = round(brewery.average)
	}
	
}
