//
//  ViewController.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 11/08/22.
//

import UIKit
import Resolver
import Combine

class HomeViewController: UIViewController {
    
    @Injected var viewModel: HomeViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var emptyStatesView: EmptyState = {
        let emptyStatesView = EmptyState(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
        emptyStatesView.translatesAutoresizingMaskIntoConstraints = false
        return emptyStatesView
    }()

    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        sinkBreweries()
        getBreweriesBy(city: "New York")
        setupEmptyState()
    }
    
    func setupEmptyState() {
        self.view.addSubview(emptyStatesView)
        constraintEmptyState()
    }
    
    func hideEmptyState() {
        self.emptyStatesView.removeFromSuperview()
    }
    
    private func constraintEmptyState() {
        emptyStatesView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        emptyStatesView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        emptyStatesView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func getBreweriesBy(city: String) {
        viewModel.fetchBreweriesBy(city: city)
    }
    
    private func sinkBreweries() {
        viewModel.$state.sink { state in
            switch state {
            case .initial:
                print("initial")
            case .success(let breweries):
                print(breweries)
            case .genericError:
                print("generic")
            case .loading:
                print("loading")
            case .emptyError:
                print("emptyError")
            }
        }.store(in: &cancellables)
    }
}
extension HomeViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 0.671, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        setupNavigationBarItems()
    }
    private func setupNavigationBarItems() {
        navigationItem.title = "CI&T Brewery"
        setupLeftNavigationBar()
        setupRightNavigationBar()
    }
    private func setupLeftNavigationBar() {
        let logoIcon = UIButton(type: .system)
        logoIcon.setImage(UIImage(named: "icon"), for: .normal)
        logoIcon.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoIcon)
    }
    private func setupRightNavigationBar() {
        let favoriteIcon = UIButton(type: .system)
        favoriteIcon.setImage(UIImage(named: "favorite_border")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let starIcon = UIButton(type: .system)
        starIcon.setImage(UIImage(named: "star_border")?.withRenderingMode(.alwaysOriginal), for: .normal)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: favoriteIcon), UIBarButtonItem(customView: starIcon)]
    }
}
