//
//  RatingViewController.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 17/08/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class RatingViewController: UIViewController {
    
    @IBOutlet weak var ratingStarsView: UIView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var generalTitle: UILabel!
    private lazy var textField = MDCOutlinedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
    
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
        setupTextField()
    }
    
    private func setupTextField() {
        textField.label.text = "e-mail"
        textField.placeholder = "e-mail"
        textField.leadingAssistiveLabel.text = "This is a helper text"
        textField.sizeToFit()
        textField.delegate = self
        view.addSubview(textField)
        constraintTextField()
    }
    
    private func constraintTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.bottomAnchor.constraint(equalTo: checkboxButton.topAnchor, constant: -10).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
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

extension RatingViewController: UITextFieldDelegate {
    
}
