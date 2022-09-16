//
//  BreweryListTableViewCell.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 15/08/22.
//

import UIKit
import Resolver

class BreweryListTableViewCell: UITableViewCell {
    @IBOutlet var profileLetter: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var average: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var viewModel: HomeViewModel?
    
    var brewery: Brewery? = nil
    var buttonState: FavoriteButtonState = .unselected {
        didSet {
            updateFavoriteButton()
        }
    }
    
    func configure(for brewery: Brewery, with viewModel: HomeViewModel) {
        contentView.layer.cornerRadius = 30
        profileLetter.layer.masksToBounds = true
        profileLetter.layer.cornerRadius = 22
        profileLetter.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        profileLetter.text = "\(brewery.name.first ?? "A")"
        name.text = brewery.name
        average.text = "\(brewery.average)"
        self.brewery = brewery
        self.viewModel = viewModel
        
        buttonState = viewModel.getFavoriteButtonState(with: brewery.id)
    }
    
    @IBAction func favorite(_ sender: UIButton) {
        guard let brewery = brewery else { return }
        guard let viewModel = viewModel else { return }
        
        buttonState = viewModel.favoriteButtonTapped(brewery: brewery, state: buttonState)
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
    
    var image: UIImage? {
        switch self {
        case .selected: return UIImage(systemName: "heart.fill")
        case .unselected: return UIImage(systemName: "heart")
        }
    }
}
