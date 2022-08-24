//
//  RatingViewController.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 17/08/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import Resolver
import Combine
import Cosmos

class RatingViewController: UIViewController {
    
    @IBOutlet weak var ratingStarsView: CosmosView! {
        didSet {
            ratingStarsView.rating = 0
            ratingStarsView.settings.fillMode = .full
            ratingStarsView.didTouchCosmos = self.validaCosmosView
        }
    }
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var generalTitle: UILabel!
    private lazy var textField = MDCOutlinedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
    
    let id: String
    var brewery: Brewery? = nil {
        didSet {
            setGeneralTitle()
        }
    }
    
    @Injected private var ratingViewModel: RatingViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    @IBAction func dismissRatingView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    init(id: String) {
        self.id = id
        super.init(nibName: "RatingViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureCheckbox()
        setupTextField()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        sinkEmailState()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 100
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupTextField() {
        textField.label.text = "e-mail"
        textField.placeholder = "e-mail"
        textField.sizeToFit()
        textField.trailingViewMode = .unlessEditing
        textField.leadingViewMode = .always
        textField.leadingView = UIImageView(image: UIImage(named: "inputLeadingLabel"))
        textField.delegate = self
        view.addSubview(textField)
        constraintTextField()
        self.view.subviews.first?.layer.cornerRadius = 20
    }
    
    private func constraintTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.bottomAnchor.constraint(equalTo: checkboxButton.topAnchor, constant: 0).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
    }
    
    @IBAction func onSaveButtonTapped(_ sender: Any) {
        _ = textFieldShouldReturn(textField)
        guard let emailText = textField.text else {
            return
        }
        
        if checkboxButton.isSelected {
            saveUserEmailInFileStorage(emailText: emailText)
        }
    }
    
    @IBAction func onCheckboxTapped(_ sender: Any) {
        checkboxButton.isSelected.toggle()
    }
    
    private func saveUserEmailInFileStorage(emailText: String) {
        ratingViewModel.saveUserEmailInFileStorage(emailText: emailText)
    }
    
    private func validaCosmosView(_ double: Double) {
        guard let emailText = textField.text else { return }
        ratingViewModel.fieldsValidation(emailText: emailText, rating: ratingStarsView.rating)
    }
    
    func configureCheckbox() {
        checkboxButton.setImage(UIImage(named: "Unchecked"), for: .normal)
        checkboxButton.setImage(UIImage(named: "Checked"), for: .selected)
        checkboxButton.setImage(UIImage(named: "CheckboxDisabled"), for: .disabled)
        
        ratingViewModel.fieldsValidation(emailText: "", rating: 0)
    }
        
    func setGeneralTitle() {
        generalTitle.text = NSLocalizedString("ratingTitle", comment: "") + (brewery?.name ?? "")
    }
    
    private func sinkEmailState() {
        ratingViewModel.$fieldsState.sink { [weak self] state in
            switch state {
            case .blank:
                self?.blankFields()
            case .valid:
                self?.enabledFields()
            case .invalid:
                self?.disabledFields()
            }
        }.store(in: &cancellables)
    }
        
    private func enabledFields() {
        textField.trailingView = nil
        textField.setOutlineColor(UIColor.outlineGreen(), for: .normal)
        textField.leadingAssistiveLabel.text = ""
        saveButton.isEnabled = true
        saveButton.configuration?.background.backgroundColor = UIColor.breweryYellowLight()
        checkboxButton.isEnabled = true
    }
    
    private func blankFields() {
        textField.trailingView = nil
        textField.setOutlineColor(UIColor.outlineBlack(), for: .normal)
        textField.leadingAssistiveLabel.text = ""
        saveButton.isEnabled = false
        saveButton.configuration?.background.backgroundColor = UIColor.grayLighter()
        checkboxButton.isEnabled = false
    }
    
    private func disabledFields() {
        textField.trailingView = UIImageView(image: UIImage(named: "inputTrailingLabel"))
        textField.setOutlineColor(UIColor.outlineRed(), for: .normal)
        textField.leadingAssistiveLabel.text = NSLocalizedString("emailInvalid", comment: "")
        saveButton.isEnabled = false
        saveButton.configuration?.background.backgroundColor = UIColor.grayLighter()
        checkboxButton.isEnabled = false
    }
}

extension RatingViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField.leadingAssistiveLabel.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let emailText = textField.text else {
            return
        }
        ratingViewModel.fieldsValidation(emailText: emailText, rating: ratingStarsView.rating)
    }
}
