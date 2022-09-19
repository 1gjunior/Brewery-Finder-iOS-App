//
//  DeleteFavoriteView.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 15/09/22.
//

import Foundation
import UIKit

class DeleteFavoriteView: UIViewController{
	
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

	 init(frame: CGRect) {
		 super.init(nibName: "DeleteFavoriteView", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		 super.init(coder: coder)
	}
	
	@IBAction func cancelRemoval(_ sender: UIButton) {
		dismiss(animated: true)
	}
	@IBAction func confirmRemoval(_ sender: UIButton) {
		dismiss(animated: true)
	}

}
