//
//  FillEmailView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 13/09/22.
//

import Foundation
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class FillEmailView: UIView {
    private lazy var textField = MDCOutlinedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    
    @IBOutlet var view: UIView!    
    @IBOutlet weak var viewTitle: UILabel! {
        didSet {
            viewTitle.text = NSLocalizedString("ratedFillEmailTitle", comment: "")
            viewTitle.font = UIFont.robotoMedium(ofSize: 18)
            viewTitle.textColor = UIColor.breweryBlack()
            viewTitle.lineBreakMode = .byWordWrapping
            viewTitle.numberOfLines = 2
        }
    }
    @IBOutlet weak var checkbox: UIButton! {
        didSet {
            checkbox.titleLabel?.text = ""
            checkbox.setImage(UIImage(named: "Unchecked"), for: .normal)
            checkbox.setImage(UIImage(named: "Checked"), for: .selected)
            checkbox.setImage(UIImage(named: "CheckboxDisabled"), for: .disabled)
            checkbox.isEnabled = false
        }
    }
    @IBOutlet weak var checkboxStackView: UIStackView!
    @IBOutlet weak var checkboxText: UILabel! {
        didSet {
            checkboxText.text = NSLocalizedString("ratedFillEmailCheckboxText", comment: "")
            checkboxText.font = UIFont.robotoRegular(ofSize: 14)
            checkboxText.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            confirmButton.titleLabel?.text = NSLocalizedString("buttonConfirm", comment: "")
            confirmButton.titleLabel?.font = UIFont.robotoRegular(ofSize: 14)
            confirmButton.isEnabled = false
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
        guard let viewFromXib = Bundle.main.loadNibNamed("FillEmailView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        viewFromXib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewFromXib.translatesAutoresizingMaskIntoConstraints = true
        addSubview(viewFromXib)
        
        setupTextField()
    }
    
    private func setupTextField() {
        textField.label.text = "e-mail"
        textField.placeholder = "e-mail"
        textField.sizeToFit()
        textField.trailingViewMode = .unlessEditing
        textField.leadingViewMode = .always
        textField.leadingView = UIImageView(image: UIImage(named: "inputLeadingLabel"))

        view.addSubview(textField)
        constrainTextField()
    }
    
    private func constrainTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.bottomAnchor.constraint(equalTo: checkboxStackView.topAnchor, constant: -15).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: checkboxStackView.leadingAnchor, constant: 0).isActive = true
        textField.trailingAnchor.constraint(equalTo: checkboxStackView.trailingAnchor, constant: 0).isActive = true
    }
    
//    func configureCheckbox() {
//        checkboxButton.setImage(UIImage(named: "Unchecked"), for: .normal)
//        checkboxButton.setImage(UIImage(named: "Checked"), for: .selected)
//        checkboxButton.setImage(UIImage(named: "CheckboxDisabled"), for: .disabled)
//        viewModel.fieldsValidation(emailText: "", rating: 0)
//    }
}
