//
//  BrewerySortView.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 23/08/22.
//

import Foundation
import UIKit

public class SortView: UIView{
    
    var byNameButtonSelected = false
    var byRatingButtonSelected = false
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont.robotoRegular(ofSize: 16)
            titleLabel.textColor = UIColor.breweryBlack()
            titleLabel.text = NSLocalizedString("Ordenar por", comment: "")
        }
    }
    @IBOutlet weak var sortByName: UIStackView!{
        didSet {
            addBottomSeparator(uiStackView: sortByName)
        }
    }
    @IBOutlet weak var byNameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!{
        didSet {
            nameLabel.font = UIFont.robotoRegular(ofSize: 14)
            nameLabel.textColor = UIColor.breweryBlack()
            nameLabel.text = NSLocalizedString("Nome (A a Z)", comment: "")
        }
    }
    
    @IBOutlet weak var sortByRating: UIStackView!
    @IBOutlet weak var byRatingButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!{
        didSet {
            ratingLabel.font = UIFont.robotoRegular(ofSize: 14)
            ratingLabel.textColor = UIColor.breweryBlack()
            ratingLabel.text = NSLocalizedString("Nota (menor para maior)", comment: "")
        }
    }
    private func addBottomSeparator(uiStackView: UIStackView) {
        uiStackView.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.breweryGrayLight(), thickness: 1.0)
    }
    
    @IBAction func isByNameButtonSelected(_ sender: Any) {
        if byNameButtonSelected == false {
            byNameButtonSelected = true
            customizeNameButtonSelected()
        }
        else {
            byNameButtonSelected = false
            customizeNameButtonNoSelected()
        }
    }
    @IBAction func isByRatingButtonSelected(_ sender: Any) {
        if byRatingButtonSelected == false {
            byRatingButtonSelected = true
            customizeRatingButtonSelected()
        }
        else {
            byRatingButtonSelected = false
            customizeRatingButtonNoSelected()
        }
    }
    
    func customizeNameButtonSelected(){
        byNameButton.setImage(UIImage(named: "RadioSelected"), for: .normal)
    }
    func customizeNameButtonNoSelected(){
        byNameButton.setImage(UIImage(named: "RadioDisabled"), for: .normal)
    }
    func customizeRatingButtonSelected(){
        byRatingButton.setImage(UIImage(named: "RadioSelected"), for: .normal)
    }
    func customizeRatingButtonNoSelected(){
        byRatingButton.setImage(UIImage(named: "RadioDisabled"), for: .normal)
    }
    
}


