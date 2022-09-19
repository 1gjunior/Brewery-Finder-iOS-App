//
//  CarouselCellView.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 19/08/22.
//

import UIKit
import Kingfisher

class CarouselCellView: UICollectionViewCell {
    
	@IBOutlet weak var distance: UILabel!{
		didSet{
			distance.isHidden = true
		}
	}
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var averageRating: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    public func configure(_ brewery: Brewery) {
        self.type.text = brewery.type
        self.averageRating.text = "\(brewery.average)"
        self.name.text = brewery.name
        if let urlImage = brewery.photos?.first {
            self.imageView.kf.setImage(with: URL(string: urlImage ?? ""))
        }
    }
}
