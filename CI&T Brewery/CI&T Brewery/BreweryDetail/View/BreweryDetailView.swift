//
//  BreweryDetailView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import UIKit

class BreweryDetailView: UIView {
    @IBOutlet var view: UIView! {
        didSet {
            view.layer.cornerRadius = 30
        }
    }
        
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var address: UILabel!
}
