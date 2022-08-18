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
//        configureCheckbox()
//        changeSaveButtonColor()
//        setupTextField()
//        setupSucessStateEvaluation()
        setupFailureStateEvaluation()
    }
    
    private func setupTextField() {
        textField.label.text = "e-mail"
        textField.placeholder = "e-mail"
        textField.sizeToFit()
        textField.trailingViewMode = .unlessEditing
        textField.leadingViewMode = .always
        textField.leadingView = UIImageView(image: UIImage(named: "inputLeadingLabel"))
        textField.delegate = self
        //view.addSubview(textField)
        //constraintTextField()
    }
    
    private lazy var sucessStateView: SucessStateView = {
        let sucessStateView = SucessStateView(frame: CGRect(x: 10, y: 0, width: 380.0, height: view.frame.height))
        sucessStateView.translatesAutoresizingMaskIntoConstraints = false
        return sucessStateView
    }()
    
    private lazy var failureStateView: FailureStateView = {
        let failureStateView = FailureStateView(frame: CGRect(x: 0.0, y: 0.0, width: 500.0, height: 250.0))
        failureStateView.translatesAutoresizingMaskIntoConstraints = false
        return failureStateView
    }()
    
    func setupSucessStateEvaluation() {
        self.view.addSubview(sucessStateView)
        self.constraintSucessState()
    }
    
    func setupFailureStateEvaluation() {
        self.view.addSubview(failureStateView)
        self.constraintFailureState()
    }
    
    private func constraintSucessState() {
        sucessStateView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        sucessStateView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        sucessStateView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    private func constraintFailureState() {
        failureStateView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        failureStateView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        failureStateView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    private func constraintTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.bottomAnchor.constraint(equalTo: checkboxButton.topAnchor, constant: -10).isActive = true

        textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
    }

    @IBAction func onSaveButtonTapped(_ sender: Any) {
        _ = textFieldShouldReturn(textField)
    }
    
    @IBAction func onCheckboxTapped(_ sender: Any) {
        checkboxButton.isSelected.toggle()
    }
    
    func configureCheckbox() {
        checkboxButton.setImage(UIImage(named: "Unchecked"), for: .normal)
        checkboxButton.setImage(UIImage(named: "Checked"), for: .selected)
    }
    
    func changeSaveButtonColor() {
        if saveButton.isEnabled {
            saveButton.configuration?.background.backgroundColor = UIColor(red: 1, green: 0.867, blue: 0.294, alpha: 1)
        } else {
            saveButton.configuration?.background.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        }
    }
    
    func setGeneralTitle() {
        generalTitle.text = NSLocalizedString("ratingTitle", comment: "") + (brewery?.name ?? "")
    }
    
    func changeEmailState(_ state: EmailState) {
        textField.trailingView = state.trailingLabel
        textField.setOutlineColor(state.outlineColor, for: .normal)
        textField.leadingAssistiveLabel.text = state.leadingAssistiveLabel
        saveButton.isEnabled = state == .valid
        changeSaveButtonColor()
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
        if (textField.text?.isEmpty ?? true) {
            changeEmailState(.blank)
        } else if textField.isEmail() {
            changeEmailState(.valid)
        } else {
            changeEmailState(.invalid)
        }
    }
}




enum EmailState {
    case blank
    case invalid
    case valid
    
    var trailingLabel: UIImageView? {
        switch self {
            case .blank: return nil
            case .invalid: return UIImageView(image: UIImage(named: "inputTrailingLabel"))
            case .valid: return nil
        }
    }
    
    var outlineColor: UIColor {
        switch self {
           case .blank: return UIColor(red: 0.255, green: 0.286, blue: 0.255, alpha: 1)     // BLACK
           case .invalid: return UIColor(red: 0.729, green: 0.106, blue: 0.106, alpha: 1)   // RED
           case .valid: return UIColor(red: 0.024, green: 0.427, blue: 0.216, alpha: 1)     // GREEN
        }
    }
    
    var leadingAssistiveLabel: String {
        switch self {
            case .blank: return ""
            case .invalid: return NSLocalizedString("emailInvalid", comment: "")
            case .valid: return ""
        }
    }
}
