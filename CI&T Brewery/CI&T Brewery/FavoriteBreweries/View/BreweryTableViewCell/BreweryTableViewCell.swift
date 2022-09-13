//
//  BreweryTableViewCell.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 12/09/22.
//

import Foundation
import UIKit

class BreweryTableViewCell: UITableViewCell {    
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
    
    func configure(_ cell: BreweryTableViewCell, for brewery: FavoriteBreweries) {
        //let firstLetter = brewery.name!.prefix(1).lowercased()
       // letterImage.text = String(brewery.name![brewery.name!.startIndex])
        letterImage.text = brewery.name!.prefix(1).lowercased()
        name.text = brewery.name
        average.text = String(format: "%.f", brewery.evaluation )
    }
}
