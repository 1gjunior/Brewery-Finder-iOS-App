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
    
    @IBOutlet var searchBar: UISearchBar!
    var currentView: UIView? = nil
    
    @Injected var viewModel: HomeViewModel
    private var cancellables: Set<AnyCancellable> = []
    var breweries: [Brewery] = [] {
        didSet {
            DispatchQueue.main.async {
                self.setupSucessState()
            }
        }
    }
    
    private lazy var listView: BreweryListView = {
        let listView = BreweryListView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 800.0))
        listView.translatesAutoresizingMaskIntoConstraints = false
        return listView
    }()
    
    private lazy var errorStatesView: ErrorState = {
        let errorStatesView = ErrorState(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
        errorStatesView.translatesAutoresizingMaskIntoConstraints = false
        return errorStatesView
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
        searchBar.delegate = self
    }
    
    func setupErrorState(isEmptySearch: Bool) {
        changingState(view: errorStatesView)
        self.view.addSubview(errorStatesView)
        self.errorStatesView.changeText(isEmptySearch)
        constraintEmptyState()
    }
    
    func setupSucessState() {
        listView.setSearchResultText("\(breweries.count) \(NSLocalizedString("resultsText", comment: ""))")
        self.view.addSubview(listView)
        self.constraintListView()
        self.changingState(view: listView)
        listView.update(breweries)
    }
    
    private func constraintListView() {
        listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    private func changingState(view: UIView?) {
        if view != currentView {
            currentView?.removeFromSuperview()
            currentView = view
        }
    }
    
    private func constraintEmptyState() {
        errorStatesView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        errorStatesView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        errorStatesView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func getBreweriesBy(city: String) {
        viewModel.fetchBreweriesBy(city: city)
    }
    
    private func sinkBreweries() {
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .initial:
                print("initial")
            case .success(let breweries):
                self?.sucessState(breweries)
            case .genericError:
                self?.genericErrorState()
            case .loading:
                print("loading")
            case .emptyError:
                self?.emptyErrorState()
            }
        }.store(in: &cancellables)
    }
    
    private func sucessState(_ breweries: [Brewery]) {
        DispatchQueue.main.async { [weak self] in
            self?.breweries = breweries
        }
    }
    
    private func genericErrorState() {
        DispatchQueue.main.async { [weak self] in
            self?.setupErrorState(isEmptySearch: false)
        }
    }
    
    private func emptyErrorState() {
        DispatchQueue.main.async { [weak self] in
            self?.setupErrorState(isEmptySearch: true)
        }
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

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.getBreweriesBy(city: searchBar.text ?? "")
    }
}
