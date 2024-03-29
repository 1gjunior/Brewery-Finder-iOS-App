//
//  BreweryListTableViewCell.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 15/08/22.
//

import UIKit
import Resolver

class BreweryListTableViewCell: UITableViewCell {
    @IBOutlet var profileLetter: UILabel! {
        didSet {
            profileLetter.makeRoundLabel()
        }
    }
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet var name: UILabel!
    @IBOutlet var average: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
	var onFavorite: ((Brewery, FavoriteButtonState) -> FavoriteButtonState)?
    var brewery: Brewery? = nil
    var buttonState: FavoriteButtonState = .unselected {
        didSet {
            updateFavoriteButton()
        }
    }
    
    func configure(for brewery: Brewery, onFavorite: ((Brewery, FavoriteButtonState) -> FavoriteButtonState)?) {
        profileLetter.text = brewery.name.prefix(1).uppercased()
        name.text = brewery.name
        average.text = "\(brewery.average)"
        self.brewery = brewery
        self.onFavorite = onFavorite
        favoriteButton.addTarget(self, action: #selector(favorite), for: .touchUpInside)
    }
    
    @objc func favorite(button: UIButton) {
        button.isSelected.toggle()
        guard let brewery = brewery else { return }
        if let newState = onFavorite?(brewery, buttonState) {
            buttonState = newState
        }
    }
    
    func updateFavoriteButton() {
        favoriteButton.setImage(buttonState.image, for: .normal)
        favoriteButton.tintColor = buttonState.color
    }
}

enum FavoriteButtonState {
    case selected
    case unselected
    
    var color: UIColor {
        switch self {
        case .selected: return .favoriteRedColor()
        case .unselected: return .label
        }
    }
    
    var isSelected: Bool {
        switch self {
        case .selected: return true
        case .unselected: return false
        }
    }
    
    var image: UIImage? {
        switch self {
        case .selected: return UIImage(systemName: "heart.fill")
        case .unselected: return UIImage(systemName: "heart")
        }
    }
}
