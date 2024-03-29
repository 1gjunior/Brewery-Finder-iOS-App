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
    @Injected private var favoriteManager: FavoriteBreweriesManagerProtocol
    private var favoriteBreweries: [FavoriteBreweries] = []
    @Injected var viewModel: FavoriteBreweriesViewModel
    private var cancellables: Set<AnyCancellable> = []
    private lazy var breweryList: FavoriteListView = {
        let breweryList = FavoriteListView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
        breweryList.translatesAutoresizingMaskIntoConstraints = false
        breweryList.delegate = self
        return breweryList
    }()
    
    private lazy var emptyStateView: EmptyStateView = {
        let emptyStateView = EmptyStateView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        return emptyStateView
    }()    
    
    @IBOutlet weak var mainTitle: UILabel! {
        didSet {
            mainTitle.font = UIFont.robotoRegular(ofSize: 24)
            mainTitle.textColor = UIColor.breweryBlack()
            mainTitle.text = NSLocalizedString("favoriteNavigationTitle", comment: "")
        }
    }
    
    init() {
        super.init(nibName: "FavoriteBreweriesView", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        getFavoriteBrewery()
        sinkBreweries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        loadFavorite()
		  getFavoriteBrewery()
    }
    
    private func setupSuccessState(_ breweries: [FavoriteBreweries])  {
        let localizable = breweries.count == 1 ? "resultText" : "resultsText"
        breweryList.setSearchResultFavoriteText("\(breweries.count) \(NSLocalizedString(localizable, comment: ""))")
        view.addSubview(breweryList)
        constrainBreweryList()
        favoriteBreweries = breweries
        breweryList.update(favoriteBreweries)
        breweryList.setActions(onSelect: goToDetailWith)
    }

    private func setupEmptyState() {
        changingState(view: emptyStateView)
        view.addSubview(emptyStateView)
        constrainEmptyState()
    }

    private func changingState(view: UIView?) {
        if view != currentView {
            currentView?.removeFromSuperview()
            currentView = view
        }
    }
    
    func loadFavorite(){
        _ = favoriteManager.loadFavoriteBreweries()
        breweryList.tableView.reloadData()
    }
    
    private func constrainBreweryList() {
        breweryList.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        breweryList.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        breweryList.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        breweryList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }

    private func constrainEmptyState() {
        emptyStateView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
	
    private func sinkBreweries() {
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .initial:
                print("initial")
            case .emptyError:
                self?.emptyState()
            case .loading:
                print("loading")
            case .success(breweries: let breweries):
                self?.favoriteBreweriesList(breweries)
                print("breweries favorites \(breweries)")
            case .genericError:
                print("generic")
            }
        }.store(in: &cancellables)
    }

    private func emptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.setupEmptyState()
        }
    }
    
    private func favoriteBreweriesList(_ breweries: [FavoriteBreweries]) {
        DispatchQueue.main.async { [weak self] in
            self?.setupSuccessState(breweries)
        }
    }
    
    private func getFavoriteBrewery() {
        viewModel.fetchFavoriteBrewery()
    }
    
    internal func goToDetailWith(id: String) {
        let breweryDetailViewController = BreweryDetailViewController(id: id)
        self.navigationController?.pushViewController(breweryDetailViewController, animated: true)
    }
}

extension FavoriteBreweriesViewController: FavoriteListViewDelegate {
    
    func didDeleted() {
        currentView = breweryList
        getFavoriteBrewery()
    }
    
    func didSorted(type: SortType) {
        switch type {
        case .sortedName:
            viewModel.sortedBreweries = .sortedName
        case .sortedRating:
            viewModel.sortedBreweries = .sortedRating
        }
    }
}

extension FavoriteBreweriesViewController {
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        let logoIcon = UIButton(type: .system)
        logoIcon.setImage(UIImage(named: "icon_back"), for: .normal)
        logoIcon.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoIcon)
        logoIcon.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
