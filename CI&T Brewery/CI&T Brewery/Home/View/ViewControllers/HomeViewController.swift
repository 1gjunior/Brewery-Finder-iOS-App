//
//  ViewController.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 11/08/22.
//

import UIKit
import Resolver
import Combine

class ArrayCache {
    private init() {}

    static let shared = NSCache<NSString, NSArray>()
}

class HomeViewController: UIViewController, CarouselViewDelegate {
    
    @IBOutlet var searchBar: UISearchBar!{
        didSet{
            searchBar.searchTextField.layer.cornerRadius = 20
            searchBar.searchTextField.layer.masksToBounds = true
            searchBar.placeholder = NSLocalizedString("searchPlaceholder", comment: "")
            searchBar.searchTextField.backgroundColor = UIColor.BreweryYellowPale()
            searchBar.searchTextField.font = UIFont.robotoRegular(ofSize: 14)
        }
    }
	@IBOutlet weak var useLocationButton: UIButton!{
		didSet{
			useLocationButton.isHidden = true
		}
	}
	
    private var currentView: UIView? = nil
    
    @Injected var viewModel: HomeViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private var top10Breweries: [Brewery] = []
    
    private lazy var listView: BreweryListView = {
        let listView = BreweryListView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 800.0))
        listView.translatesAutoresizingMaskIntoConstraints = false
        listView.delegate = self
        return listView
    }()
    
    private lazy var errorStateView: ErrorStateView = {
        let errorStateView = ErrorStateView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
        errorStateView.translatesAutoresizingMaskIntoConstraints = false
        return errorStateView
    }()
    
    private lazy var carouselView: CarouselView = {
        let carouselView = CarouselView(frame: CGRect())
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.delegate = self
        return carouselView
    }()
    
    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sinkBreweries()
        sinkTop10Breweries()
        searchBar.delegate = self
        getTop10Breweries()
        hideKeyboard()
        
        viewModel.loadFavoriteBreweries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listView.reloadTableView()
        setupNavigationBar()
    }
    
    func setupErrorState(error: EmptyError) {
        changingState(view: errorStateView)
        view.addSubview(errorStateView)
        errorStateView.changeText(error)
        constraintErrorState()
    }
    
    func setupSucessState(_ breweries: [Brewery]) {
        let localizable = breweries.count == 1 ? "resultText" : "resultsText"
        listView.setSearchResultText("\(breweries.count) \(NSLocalizedString(localizable, comment: ""))")
        view.addSubview(listView)
        constraintListView()
        changingState(view: listView)
        listView.update(breweries)
        listView.configure(onSelect: goToDetailWith, viewModel: viewModel)
    }
    
    func setupTop10SucessState(_ breweries: [Brewery]) {
        view.addSubview(carouselView)
        constraintCarouselView()
        changingState(view: carouselView)
        manageTopTenInCache(breweries)
    }
    
    private func manageTopTenInCache(_ breweries: [Brewery]) {
        if let cachedVersion = ArrayCache.shared.object(forKey: "TopTenBreweries") as? [Brewery] {
            carouselView.breweries = cachedVersion
        } else {
            ArrayCache.shared.setObject(breweries as NSArray, forKey: "TopTenBreweries")
            carouselView.breweries = breweries
        }
    }
    
    internal func goToDetailWith(id: String) {
        let breweryDetailViewController = BreweryDetailViewController(id: id)
        breweryDetailViewController.dismissAction = updateBrewery
        self.navigationController?.pushViewController(breweryDetailViewController, animated: true)
    }
    
    private func updateBrewery() {
        getBreweriesBy(city: searchBar.text ?? "")
    }
    
    private func constraintListView() {
        listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        listView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func constraintCarouselView() {
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        carouselView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        carouselView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        carouselView.heightAnchor.constraint(equalToConstant: 600).isActive = true
    }
    
    private func changingState(view: UIView?) {
        if view != currentView {
            currentView?.removeFromSuperview()
            currentView = view
        }
    }
    
    private func constraintErrorState() {
        errorStateView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        errorStateView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        errorStateView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func getBreweriesBy(city: String) {
        viewModel.fetchBreweriesBy(city: city)
    }
    
    @objc private func getTop10Breweries() {
        viewModel.fetchTop10Breweries()
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
    
    private func sinkTop10Breweries() {
        viewModel.$top10BreweriesState.sink { [weak self] state in
            switch state {
            case .initial:
                print("initial")
            case .success(let breweries):
                self?.sucessStateTop10(breweries)
            case .genericError:
                self?.manageTopTenInCache([])
            case .loading:
                print("loading")
            case .emptyError:
                print("empty error")
            }
        }.store(in: &cancellables)
    }
    
    private func sucessState(_ breweries: [Brewery]) {
        DispatchQueue.main.async { [weak self] in
            self?.setupSucessState(breweries)
        }
    }
    
    private func sucessStateTop10(_ breweries: [Brewery]) {
        DispatchQueue.main.async { [weak self] in
            self?.setupTop10SucessState(breweries)
        }
    }
    
    private func genericErrorState() {
        DispatchQueue.main.async { [weak self] in
            self?.setupErrorState(error: .result)
        }
    }
    
    private func emptyErrorState() {
        DispatchQueue.main.async { [weak self] in
            self?.setupErrorState(error: .search)
        }
    }
}

extension HomeViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor.yellowDark()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.accessibilityIdentifier = "home_nav_bar"
        setupNavigationBarItems()
    }
    
    private func setupNavigationBarItems() {
        navigationItem.title = NSLocalizedString("navigatioBarnTitle", comment: "String")
        setupLeftNavigationBar()
        setupRightNavigationBar()
    }
    
    private func setupLeftNavigationBar() {
        let logoIcon = UIButton(type: .system)
        logoIcon.setImage(UIImage(named: "icon"), for: .normal)
        logoIcon.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoIcon)
        logoIcon.addTarget(self, action: #selector(getTop10Breweries), for: .touchUpInside)
    }
    
    private func setupRightNavigationBar() {
        let favoriteIcon = UIButton(type: .system)
        favoriteIcon.setImage(UIImage(named: "favorite_border")?.withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteIcon.addTarget(self, action: #selector(didTapFavoriteButton), for: UIControl.Event.touchUpInside)
        
        let starIcon = UIButton(type: .system)
        starIcon.setImage(UIImage(named: "star_border")?.withRenderingMode(.alwaysOriginal), for: .normal)
        starIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        starIcon.addTarget(self, action: #selector(didTapRatingButton), for: UIControl.Event.touchUpInside)
        starIcon.accessibilityIdentifier = "rated_breweries_button"
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: favoriteIcon),
            UIBarButtonItem(customView: starIcon)
        ]
    }
    
    @objc private func didTapRatingButton() {
        let ratedVC = RatedBreweriesViewController()
        self.navigationController?.pushViewController(ratedVC, animated: true)
    }
    
    @objc private func didTapFavoriteButton() {
        let favoriteVC = FavoriteBreweriesViewController()
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.updateBrewery()
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if searchBar.selectedScopeButtonIndex == 1{
            self.updateBrewery()}
    }
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension HomeViewController: BreweryListViewDelegate{
    
    func didSorted(type: SortType) {
        switch type{
        case .sortedName:
            viewModel.sortedBreweries = .sortedName
        case .sortedRating:
            viewModel.sortedBreweries = .sortedRating
        }
    }
}
