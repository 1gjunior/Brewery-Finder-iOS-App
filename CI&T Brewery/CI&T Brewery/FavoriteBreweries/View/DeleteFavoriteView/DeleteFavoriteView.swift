//
//  DeleteFavoriteView.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 15/09/22.
//

import Foundation
import UIKit

class DeleteFavoriteView: UIView{
	
	@IBOutlet var mainView: UIView!
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

	override init(frame: CGRect) {
		 super.init(frame: frame)
		 commonInit()
	}
	
	required init?(coder: NSCoder) {
		 super.init(coder: coder)
		 commonInit()
	}
	
	public func commonInit() {
		 guard let viewFromXib = Bundle.main.loadNibNamed("DeleteFavoriteView", owner: self, options: nil)?[0] as? UIView else { return }
		 viewFromXib.frame = self.bounds
		 addSubview(viewFromXib)
	}
	
	@IBAction func cancelRemoval(_ sender: UIButton) {
		print("cancelou")
	}
	@IBAction func confirmRemoval(_ sender: UIButton) {
		print("excluiu")
	}

}
