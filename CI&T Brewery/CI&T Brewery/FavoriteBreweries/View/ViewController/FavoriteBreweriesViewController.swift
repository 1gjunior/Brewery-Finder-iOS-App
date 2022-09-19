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
        return breweryList
    }()
    
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
        getFavoriteBrewery()
        sinkBreweries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupSuccessState(_ breweries: [FavoriteBreweries])  {
        breweryList.setSearchResultFavoriteText("\(breweries.count) \(NSLocalizedString("resultsText", comment: ""))")
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
        favoriteManager.loadFavoriteBreweries()
        breweryList.tableView.reloadData()
    }
    
    private func constrainBreweryList() {
        breweryList.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
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
        let lbNavTitle = UILabel(frame: CGRect(x: 0, y: 40, width: 320, height: 40))
        lbNavTitle.textAlignment = .left
        lbNavTitle.text = NSLocalizedString("favoriteNavigationTitle", comment: "")
        lbNavTitle.textColor = .breweryBlack()
        lbNavTitle.font = UIFont.robotoRegular(ofSize: 22)
        
        self.navigationItem.titleView = lbNavTitle
        self.navigationController?.navigationBar.tintColor = .black
    }
}
