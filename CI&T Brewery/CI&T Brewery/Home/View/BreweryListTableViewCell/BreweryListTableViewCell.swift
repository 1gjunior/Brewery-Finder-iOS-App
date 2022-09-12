//
//  BreweryListTableViewCell.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 15/08/22.
//

import UIKit

class BreweryListTableViewCell: UITableViewCell {
    @IBOutlet var profileLetter: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var average: UILabel!
    var id: String? = nil
    var buttonState: ButtonState = .unselected
    
    func configure(_ cell: BreweryListTableViewCell, for brewery: Brewery) {
        cell.contentView.layer.cornerRadius = 30
        cell.profileLetter.layer.masksToBounds = true
        cell.profileLetter.layer.cornerRadius = 22
        cell.profileLetter.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)

        profileLetter.text = "\(brewery.name.first ?? "A")"
        name.text = brewery.name
        average.text = "\(brewery.average)"
        id = brewery.id
    }
    
    //TODO: INTEGRATION WITH CORE DATA
    @IBAction func favorite(_ sender: UIButton) {
        if buttonState == .unselected {
            buttonState = .selected
        } else {
            buttonState = .unselected
        }
        
        sender.setImage(buttonState.image, for: .normal)
        sender.tintColor = buttonState.color
    }
    
    enum ButtonState {
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
}
