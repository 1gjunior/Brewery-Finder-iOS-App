//
//  FavoriteBreweriesViewController.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 12/09/22.
//

import Combine
import Resolver
import UIKit

class FavoriteBreweriesViewController: UIViewController {
    private var currentView: UIView?

    @Injected var viewModel: FavoriteBreweriesViewModel
    private var cancellables: Set<AnyCancellable> = []

    private lazy var emptyStateView: EmptyStateView = {
        let emptyStateView = EmptyStateView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        return emptyStateView
    }()

    init() {
        super.init(nibName: "FavoriteBreweriesView", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        sinkBreweries()
    }

    func setupEmptyState() {
        changingState(view: emptyStateView)
        view.addSubview(emptyStateView)
        constraintEmptyState()
    }

    private func changingState(view: UIView?) {
        if view != currentView {
            currentView?.removeFromSuperview()
            currentView = view
        }
    }

    private func constraintEmptyState() {
        emptyStateView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }

    private func sinkBreweries() {
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .initial:
                print("initial")
            case .empty:
                self?.emptyState()
            }
        }.store(in: &cancellables)
    }

    private func emptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.setupEmptyState()
        }
    }
}

extension FavoriteBreweriesViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor.yellowDark()
        navigationController?.navigationBar.isTranslucent = false
        setupNavigationBarItems()
    }

    private func setupNavigationBarItems() {
        setupLeftNavigationBar()
    }

    private func setupLeftNavigationBar() {
        let logoIcon = UIButton(type: .system)
        logoIcon.setImage(UIImage(named: "icon_back"), for: .normal)
        logoIcon.tintColor = .black

        navigationItem.backBarButtonItem = UIBarButtonItem(customView: logoIcon)
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
    }
}
