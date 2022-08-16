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
    
    @Injected var viewModel: HomeViewModel
    private var cancellables: Set<AnyCancellable> = []
    var breweries: [Brewery] = [] {
        didSet {
            DispatchQueue.main.async {
                self.setupSucessState()
                self.listView.tableView.reloadData()
            }
        }
    }
    
    private lazy var listView: BreweryListView = {
        let listView = BreweryListView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 800.0))
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
    
        listView.tableView.register(UINib(nibName: "BreweryListTableViewCell", bundle: nil), forCellReuseIdentifier: "BreweryListCell")
        return listView
    }()
    
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
        searchBar.delegate = self
        listView.tableView.register(UINib(nibName: "BreweryListTableViewCell", bundle: nil), forCellReuseIdentifier: "BreweryListCell")
    }
    
    func setupEmptyState() {
        self.view.addSubview(emptyStatesView)
        constraintEmptyState()
    }
    
    func setupSucessState() {
        DispatchQueue.main.async { [weak self] in
            self?.view.addSubview(self?.listView ?? UIView())
            self?.constraintListView()
        }
    }
    
    private func constraintListView() {
        listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func hideEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.emptyStatesView.removeFromSuperview()
        }
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
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .initial:
                print("initial")
            case .success(let breweries):
                self?.hideEmptyState()
                self?.breweries = breweries
            case .genericError:
                print("generic")
            case .loading:
                print("loading")
            case .emptyError:
                self?.setupEmptyState()
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryListCell", for: indexPath) as? BreweryListTableViewCell else { fatalError("Cannot create a cell") }
        
        let brewery = breweries[indexPath.section]
        cell.configure(cell, brewery)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        breweries.count
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.getBreweriesBy(city: searchBar.text ?? "")
    }
}
