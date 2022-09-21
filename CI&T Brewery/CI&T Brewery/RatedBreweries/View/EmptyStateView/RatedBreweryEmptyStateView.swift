//
//  RatedBreweryEmptyState.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 14/09/22.
//

import Foundation
import UIKit

class RatedBreweryEmptyStateView: UIView {
    @IBOutlet weak var mainTitle: UILabel! {
        didSet {
            mainTitle.font = UIFont.robotoMedium(ofSize: 20)
            mainTitle.textColor = .black
            mainTitle.text = NSLocalizedString("ratedEmptyStateTitle", comment: "")
            mainTitle.accessibilityIdentifier = "main_title_label_rated_breweries"
        }
    }
    @IBOutlet weak var subTitle: UILabel! {
        didSet{
            subTitle.font = UIFont.robotoLight(ofSize: 16)
            subTitle.textColor = .black
            subTitle.text = NSLocalizedString("ratedEmptyStateSubTitle", comment: "")
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit() {
        guard let view = Bundle.main.loadNibNamed("RatedBreweryEmptyStateView", owner: self, options: nil)?[0] as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
