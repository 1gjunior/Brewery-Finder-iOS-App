//
//  BreweryListTableViewCell.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 15/08/22.
//

import UIKit

class BreweryListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileLetter: UILabel!
    
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
        cell.profileLetter.layer.cornerRadius = 20
        cell.profileLetter.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
//        cell.profileLetter.textAlignment = .center
//        cell.profileLetter.layer.cornerRadius = 25
//        cell.layer.backgroundColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
//        cell.contentView.layer.backgroundColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
    }
    
    func addInitials(first: String, second: String) {
        let initials = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        initials.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        initials.textAlignment = .center
        initials.text = first + " " + second
        initials.textColor = .black
        self.addSubview(initials)
    }
    
}
