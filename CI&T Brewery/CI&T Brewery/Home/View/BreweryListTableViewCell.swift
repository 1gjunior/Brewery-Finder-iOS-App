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

    func configure(_ cell: BreweryListTableViewCell, for brewery: Brewery) {
        cell.contentView.layer.cornerRadius = 30
        cell.profileLetter.layer.masksToBounds = true
        cell.profileLetter.layer.cornerRadius = 22
        cell.profileLetter.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)

        profileLetter.text = "\(brewery.name.first ?? "A")"
        name.text = brewery.name
        average.text = "\(brewery.average)"
    }
}
