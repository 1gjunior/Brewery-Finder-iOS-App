//
//  RatingViewController.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 17/08/22.
//

import Foundation
import UIKit

class RatingViewController: UIViewController {
    
    @IBOutlet weak var ratingStarsView: UIView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var generalTitle: UILabel!
    var brewery: Brewery? = nil {
        didSet {
            setGeneralTitle()
        }
    }
    
    @IBAction func dismissRatingView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    init() {
        super.init(nibName: "RatingViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        configureCheckbox()
        changeSaveButton()
    }
    
    @IBAction func onSaveButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func onCheckboxTapped(_ sender: Any) {
        checkboxButton.isSelected.toggle()
    }
    
    func configureCheckbox() {
        checkboxButton.setImage(UIImage(named: "Unchecked"), for: .normal)
        checkboxButton.setImage(UIImage(named: "Checked"), for: .selected)
    }
    
    func changeSaveButton() {
        if saveButton.isEnabled {
            saveButton.configuration?.background.backgroundColor = UIColor(red: 1, green: 0.867, blue: 0.294, alpha: 1)
        } else {
            saveButton.configuration?.background.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        }
    }
    
    func setGeneralTitle() {
        generalTitle.text = NSLocalizedString("ratingTitle", comment: "") + (brewery?.name ?? "")
    }
}
