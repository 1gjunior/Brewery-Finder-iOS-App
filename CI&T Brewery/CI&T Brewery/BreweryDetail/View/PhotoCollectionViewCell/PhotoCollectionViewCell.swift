//
//  PhotoCollectionViewCell.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/09/22.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var photo: UIImageView!
}
