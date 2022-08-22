//
//  RatingView.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 22/08/22.
//

import Foundation
import UIKit

public class RatingvView: UIView {
    
    @IBOutlet weak var ratingView: UIView!
    weak var delegate: ShowRatedBreweryDelegate?
    var wasSucess: Bool?
    @IBOutlet weak var checkboxLabel: UILabel!
    @IBOutlet weak var ratingStarsView: UIView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var generalTitle: UILabel!
    
    
}
