//
//  BreweryTableViewCell.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 12/09/22.
//

import Foundation
import UIKit

protocol FavoriteCellActionDelegate{
	func didFavoriteButtonTapped(brewery: FavoriteBreweries)
}

class BreweryTableViewCell: UITableViewCell {
	var delegate: FavoriteCellActionDelegate?
	var brewery: FavoriteBreweries? = nil
	var favoriteListView = FavoriteListView()
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 30
        }
    }
    
    @IBOutlet weak var letterImage: UILabel! {
        didSet {
            letterImage.makeRoundLabel()
        }
    }
    @IBOutlet weak var name: UILabel! {
        didSet {            
            name.font = UIFont.robotoRegular(ofSize: 16)
            name.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var average: UILabel! {
        didSet {
            average.font = UIFont.robotoLight(ofSize: 14)
            average.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var type: UILabel! {
        didSet {
            type.font = UIFont.robotoLight(ofSize: 14)
            type.textColor = UIColor.breweryBlack()
        }
    }
	@IBOutlet weak var favoriteButton: UIButton!{
		didSet{
			favoriteButton.tintColor = UIColor.favoriteRedColor()
		}
	}
		
    func configure(for brewery: FavoriteBreweries) {
        guard let breweryName = brewery.name else {return}
        letterImage.text = breweryName.prefix(1).uppercased()
        name.text = brewery.name
        average.text = "\(brewery.evaluation)"
        type.text = brewery.type
			self.brewery = brewery
    }

	@IBAction func removeFavorite(_ sender: UIButton) {
		if let delegate = self.delegate, let brewery = brewery{
			delegate.didFavoriteButtonTapped(brewery: brewery)
		}
	}
}
