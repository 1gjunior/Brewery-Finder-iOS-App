//
//  RatingViewController.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 17/08/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import Combine
import Resolver
import Combine
import Cosmos

class RatingViewController: UIViewController {
    
    var dismissActionBreweryDetail: (() -> ())?
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var checkboxLabel: UILabel!
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
    private var cancellables: Set<AnyCancellable> = []
    @Injected private var viewModel: RatingViewModel
    var id: String?
    var ratingStars: Double?
    let breweryObject: BreweryObject?
    var brewery: Brewery? = nil {
        didSet {
            setGeneralTitle()
        }
    }
    
    @IBAction func dismissRatingView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    init(breweryObject: BreweryObject, id: String) {
        self.breweryObject = breweryObject
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
        setGeneralTitle()
        observeRating()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didEndEditing))
        ratingView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didEndEditing() {
        textField.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let dismissActionBreweryDetail = dismissActionBreweryDetail else {return}
        dismissActionBreweryDetail()
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
    
    private lazy var sucessStateView: SucessStateView = {
        let sucessStateView = SucessStateView(frame: CGRect(x: 10, y: 0, width: 380.0, height: view.frame.height))
        sucessStateView.translatesAutoresizingMaskIntoConstraints = false
        return sucessStateView
    }()
    
    private lazy var failureStateView: FailureStateView = {
        let failureStateView = FailureStateView(frame: CGRect(x: 0.0, y: 0.0, width: 380.0, height: 250.0))
        failureStateView.translatesAutoresizingMaskIntoConstraints = false
        return failureStateView
    }()
    
    func setupSucessStateEvaluation() {
        hideElementsRatingView()
        let sucessLabel = NSLocalizedString("EvaluationAddSucess", comment: "")
        sucessStateView.sucessStateLabel.text = sucessLabel
        self.view.addSubview(sucessStateView)
        self.constraintSucessState()
    }
    
    func setupFailureStateEvaluation() {
        hideElementsRatingView()
        let failureLabel = NSLocalizedString("EvaluationAddFailure", comment: "")
        failureStateView.failureStateLabel.text = failureLabel
        self.view.addSubview(failureStateView)
        self.constraintFailureState()
    }
    
    private func constraintSucessState() {
        sucessStateView.topAnchor.constraint(equalTo: self.ratingView.topAnchor, constant: 70).isActive = true
        sucessStateView.leadingAnchor.constraint(equalTo: self.ratingView.leadingAnchor, constant: 0).isActive = true
        sucessStateView.trailingAnchor.constraint(equalTo: self.ratingView.trailingAnchor, constant: 0).isActive = true
    }
    
    private func constraintFailureState() {
        failureStateView.topAnchor.constraint(equalTo: self.ratingView.topAnchor, constant: 70).isActive = true
        failureStateView.leadingAnchor.constraint(equalTo: self.ratingView.leadingAnchor, constant: 0).isActive = true
        failureStateView.trailingAnchor.constraint(equalTo: self.ratingView.trailingAnchor, constant: 0).isActive = true
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
        
        ratingStars = ratingStarsView.rating
        guard let id = id else {return}
        let uploadBreweryEvaluation: BreweryEvaluation = .init(email: emailText, breweryId: id, evaluationGrade: self.ratingStars!)
        viewModel.post(evaluation: uploadBreweryEvaluation)
    }
    
    @IBAction func onCheckboxTapped(_ sender: Any) {
        checkboxButton.isSelected.toggle()
    }
    
    private func saveUserEmailInFileStorage(emailText: String) {
        viewModel.saveUserEmailInFileStorage(emailText: emailText)
    }
    
    private func validaCosmosView(_ double: Double) {
        guard let emailText = textField.text else { return }
        viewModel.fieldsValidation(emailText: emailText, rating: ratingStarsView.rating)
    }
    
    func configureCheckbox() {
        checkboxButton.setImage(UIImage(named: "Unchecked"), for: .normal)
        checkboxButton.setImage(UIImage(named: "Checked"), for: .selected)
        checkboxButton.setImage(UIImage(named: "CheckboxDisabled"), for: .disabled)
        viewModel.fieldsValidation(emailText: "", rating: 0)
    }
    
    func setGeneralTitle() {
        generalTitle.text = NSLocalizedString("ratingTitle", comment: "") + " " + (breweryObject?.name ?? "")
    }
    
    private func sinkEmailState() {
        viewModel.$fieldsState.sink { [weak self] state in
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
    
    func hideElementsRatingView() {
        checkboxLabel.isHidden = true
        ratingStarsView.isHidden = true
        checkboxButton.isHidden = true
        saveButton.isHidden = true
        generalTitle.isHidden = true
        textField.isHidden = true
    }
    
    private func sucessStateEvaluation() {
        DispatchQueue.main.async { [weak self] in
            self?.setupSucessStateEvaluation()
        }
    }
    
    private func failureStateEvaluation() {
        DispatchQueue.main.async { [weak self] in
            self?.setupFailureStateEvaluation()
        }
    }
    
    private func observeRating() {
        viewModel.$stateRating.sink { [weak self] stateRating in
            print("\(stateRating)")
            switch stateRating {
            case .initial:
                print("initial")
            case .sucess:
                print("sucess")
                self?.sucessStateEvaluation()
            case .error:
                print("error")
                self?.failureStateEvaluation()
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
        viewModel.fieldsValidation(emailText: emailText, rating: ratingStarsView.rating)
    }
}

