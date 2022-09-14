//
//  RatedBreweriesViewController.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 13/09/22.
//

import Foundation
import UIKit
import Resolver
import Combine

class RatedBreweriesViewController: UIViewController {
    @Injected var viewModel: RatedBreweriesViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var fillEmailView: FillEmailView = {
        let fillEmailView = FillEmailView(frame: CGRect())
        fillEmailView.translatesAutoresizingMaskIntoConstraints = false
        fillEmailView.textField.delegate = self
        
        return fillEmailView
    }()
    
    private lazy var emptyStateView: RatedBreweryEmptyStateView = {
        let emptyStateView = RatedBreweryEmptyStateView(frame: CGRect())
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false        
        
        return emptyStateView
    }()
    
    init() {
        super.init(nibName: "RatedBreweriesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFillEmailView()
        sinkEmailState()
        sinkRatedBreweriesState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }    
    
    private func sinkEmailState() {
        viewModel.$fieldsState.sink { [weak self] state in
            switch state {
            case .blank:
                self?.fillEmailView.blankFields()
            case .valid:
                self?.fillEmailView.enabledFields()
            case .invalid:
                self?.fillEmailView.disabledFields()
            }
        }.store(in: &cancellables)
    }
    
    private func sinkRatedBreweriesState() {
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .initial:
                print("initial2")
            case .loading:
                print("loading2")
            case .success(let breweries):
                print(breweries)
            case .emptyError:
                print("sinkRatedBreweriesState")
                self?.emptyErrorState()
            }
        }.store(in: &cancellables)
    }
    
    private func emptyErrorState() {
        print("chamando aqui")
        DispatchQueue.main.async { [weak self] in
            print("chamando aqui 2")
            self?.setupEmptyErrorState()
        }
    }
    
    func setupEmptyErrorState() {
        view.addSubview(emptyStateView)
        constrainEmptyErrorState()
    }
    
    private func constrainEmptyErrorState() {
        emptyStateView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        emptyStateView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
        
    private func setupFillEmailView()  {
        view.addSubview(fillEmailView)
        constrainFillEmailView()
    }
    
    private func constrainFillEmailView() {
        fillEmailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        fillEmailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        fillEmailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        fillEmailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}

extension RatedBreweriesViewController {
    private func setupNavigationBar() {
        let lbNavTitle = UILabel(frame: CGRect(x: 0, y: 40, width: 320, height: 40))
        lbNavTitle.textAlignment = .left
        lbNavTitle.text = NSLocalizedString("ratedNavigationTitle", comment: "")
        lbNavTitle.textColor = .breweryBlack()
        lbNavTitle.font = UIFont.robotoRegular(ofSize: 22)
        
        self.navigationItem.titleView = lbNavTitle
        self.navigationController?.navigationBar.tintColor = .black
    }
}

extension RatedBreweriesViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fillEmailView.textField.leadingAssistiveLabel.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fillEmailView.textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let emailText = textField.text else {
            return
        }
        viewModel.fieldsValidation(emailText: emailText)
    }
}
