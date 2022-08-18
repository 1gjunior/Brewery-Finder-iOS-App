//
//  EvaluationBrewersViewController.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 17/08/22.
//

import Foundation
import UIKit

class EvaluationBrewersViewController: UIViewController {
    
    private lazy var sucessStateView: SucessStateView = {
        let sucessStateView = SucessStateView(frame: CGRect(x: 0.0, y: 0.0, width: 380.0, height: 250.0))
        sucessStateView.translatesAutoresizingMaskIntoConstraints = false
        return sucessStateView
    }()
    
    private lazy var failureStateView: FailureStateView = {
        let failureStateView = FailureStateView(frame: CGRect(x: 0.0, y: 0.0, width: 380.0, height: 250.0))
        failureStateView.translatesAutoresizingMaskIntoConstraints = false
        return failureStateView
    }()
    
    func setupSucessStateEvaluation() {
        self.view.addSubview(sucessStateView)
        self.constraintEvolutionState(view: sucessStateView)
    }
    
    func setupFailureStateEvaluation() {
        self.view.addSubview(failureStateView)
        self.constraintEvolutionState(view: failureStateView)
    }
    
    private func constraintEvolutionState(view: UIView) {
        view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
}
