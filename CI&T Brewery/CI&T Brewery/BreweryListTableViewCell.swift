//
//  BreweryListTableViewCell.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 15/08/22.
//

import UIKit

class BreweryListTableViewCell: UITableViewCell {
    @IBOutlet var profileLetter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(_ cell: BreweryListTableViewCell) {
        cell.contentView.layer.cornerRadius = 30
        cell.profileLetter.layer.masksToBounds = true
        cell.profileLetter.layer.cornerRadius = 22
        cell.profileLetter.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
}