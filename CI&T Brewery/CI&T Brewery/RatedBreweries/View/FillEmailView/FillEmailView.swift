//
//  FillEmailView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 13/09/22.
//

import Foundation
import Resolver
import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

public protocol SubmitEmailDelegate {
    func submitEmail(email: String)
}

class FillEmailView: UIView {
    @Injected private var viewModel: RatedBreweriesViewModel
    lazy var textField = MDCOutlinedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    public var delegate: SubmitEmailDelegate?
    
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
            confirmButton.setTitle(NSLocalizedString("buttonConfirm", comment: ""), for: .normal)
            confirmButton.setTitleColor(UIColor.breweryGold(), for: .normal)
            confirmButton.titleLabel?.font = UIFont.robotoRegular(ofSize: 14)
            confirmButton.isEnabled = false
            confirmButton.accessibilityIdentifier = "confirm_button_rated_breweries"
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
        addSubview(viewFromXib)
        
        setupTextField()
    }
    
    @IBAction func didTapCheckbox(_ sender: Any) {
        checkbox.isSelected.toggle()
    }
        
    @IBAction func didTapSaveButton(_ sender: Any) {
        guard let emailText = textField.text else { return }
        delegate?.submitEmail(email: emailText)
    }
    
    private func setupTextField() {
        textField.label.text = "e-mail"
        textField.placeholder = "e-mail"
        textField.sizeToFit()
        textField.trailingViewMode = .unlessEditing
        textField.leadingViewMode = .always
        textField.leadingView = UIImageView(image: UIImage(named: "inputLeadingLabel"))
        textField.accessibilityIdentifier = "email_text_field_rated_breweries"
        
        view.addSubview(textField)
        constrainTextField()
    }
    
    private func constrainTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.bottomAnchor.constraint(equalTo: checkboxStackView.topAnchor, constant: -5).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: checkboxStackView.leadingAnchor, constant: 0).isActive = true
        textField.trailingAnchor.constraint(equalTo: checkboxStackView.trailingAnchor, constant: 0).isActive = true
    }
}

extension FillEmailView {
    func enabledFields() {
        textField.trailingView = nil
        textField.setOutlineColor(UIColor.outlineGreen(), for: .normal)
        textField.leadingAssistiveLabel.text = ""
        confirmButton.isEnabled = true
        confirmButton.configuration?.background.backgroundColor = UIColor.breweryYellowLight()
        checkbox.isEnabled = true
    }
    
    func blankFields() {
        textField.trailingView = nil
        textField.setOutlineColor(UIColor.outlineBlack(), for: .normal)
        textField.leadingAssistiveLabel.text = ""
        confirmButton.isEnabled = false
        confirmButton.configuration?.background.backgroundColor = UIColor.grayLighter()
        checkbox.isEnabled = false
    }
    
    func disabledFields() {
        textField.trailingView = UIImageView(image: UIImage(named: "inputTrailingLabel"))
        textField.setOutlineColor(UIColor.outlineRed(), for: .normal)
        textField.leadingAssistiveLabel.text = NSLocalizedString("emailInvalid", comment: "")
        confirmButton.isEnabled = false
        confirmButton.configuration?.background.backgroundColor = UIColor.grayLighter()
        checkbox.isEnabled = false
    }
}
