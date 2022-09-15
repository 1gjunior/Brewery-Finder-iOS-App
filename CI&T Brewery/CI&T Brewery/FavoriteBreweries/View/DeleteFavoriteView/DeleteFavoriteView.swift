//
//  DeleteFavoriteView.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 15/09/22.
//

import Foundation
import UIKit

class DeleteFavoriteView: UIView{
	
	@IBOutlet weak var modalView: UIView!{
		didSet{
			modalView.layer.cornerRadius = 20
		}
	}
	@IBOutlet weak var lbTitle: UILabel!{
		didSet{
			lbTitle.text = NSLocalizedString("deleteFavoriteTitle", comment: "")
			lbTitle.font = UIFont.robotoRegular(ofSize: 16)
			lbTitle.textColor = UIColor.breweryBlack()
		}
	}
	@IBOutlet weak var lbText: UILabel!{
		didSet{
			lbText.text = NSLocalizedString("deleteFavoriteText", comment: "")
			lbTitle.font = UIFont.robotoLight(ofSize: 12)
			lbTitle.textColor = UIColor.breweryBlack()
		}
	}
	@IBOutlet weak var cancelButton: UIButton!
	@IBOutlet weak var confirmButton: UIButton!
	
	
	@IBAction func cancelRemoval(_ sender: UIButton) {
	}
	@IBAction func confirmRemoval(_ sender: UIButton) {
	}
	
}
