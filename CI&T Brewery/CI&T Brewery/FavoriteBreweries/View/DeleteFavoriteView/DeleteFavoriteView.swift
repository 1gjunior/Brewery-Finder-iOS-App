//
//  DeleteFavoriteView.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 15/09/22.
//

import Foundation
import UIKit
import Resolver

class DeleteFavoriteView: UIViewController{
	@Injected var viewModel: FavoriteBreweriesViewModel
	let favoriteBrewery: FavoriteBreweries?
    var dismissActionDelete: (() -> ())?
	@IBOutlet weak var modalView: UIView!{
		didSet{
			modalView.layer.cornerRadius = 20
		}
	}
	@IBOutlet weak var lbTitle: UILabel!{
		didSet{
			lbTitle.text = NSLocalizedString("deleteFavoriteTitle", comment: "")
			lbTitle.font = UIFont.robotoRegular(ofSize: 18)
			lbTitle.textColor = UIColor.breweryBlack()
		}
	}
	@IBOutlet weak var lbText: UILabel!{
		didSet{
			lbText.text = NSLocalizedString("deleteFavoriteText", comment: "")
			lbText.font = UIFont.robotoRegular(ofSize: 16)
			lbText.textColor = UIColor.breweryBlack()
		}
	}
	@IBOutlet weak var cancelButton: UIButton!{
		didSet{
			cancelButton?.layer.borderColor = UIColor.breweryBlack().cgColor
			cancelButton?.layer.borderWidth = 1
			cancelButton?.layer.cornerRadius = 18
		}
	}
	@IBOutlet weak var confirmButton: UIButton!{
		didSet {
			confirmButton?.layer.borderColor = UIColor.breweryYellowLight().cgColor
			confirmButton?.layer.borderWidth = 1
			confirmButton?.layer.cornerRadius = 18
			confirmButton?.layer.backgroundColor = UIColor.breweryYellowLight().cgColor
		}
	}

	init(favoriteBrewery: FavoriteBreweries) {
		 self.favoriteBrewery = favoriteBrewery
		super.init(nibName: "DeleteFavoriteView", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		 fatalError("init(coder:) has not been implemented")
	}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("saindo da delete favorite view")
        guard let dismissActionDelete = dismissActionDelete else {return}
        dismissActionDelete()
    }
	
	@IBAction func cancelRemoval(_ sender: UIButton) {
		dismiss(animated: true)
	}
	@IBAction func confirmRemoval(_ sender: UIButton) {
		viewModel.removeFavorite(brewery: favoriteBrewery!)
        dismiss(animated: true)
	}
}
