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
    var breweries: [Brewery] = [] {
        didSet {
            self.listView?.tableView.reloadData()
        }
    }
    
    private lazy var listView: BreweryListView = {
        let listView = BreweyListView()
    }
    private lazy var emptyStatesView: EmptyState = {
        let emptyStatesView = EmptyState(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
        emptyStatesView.translatesAutoresizingMaskIntoConstraints = false
        return emptyStatesView
    }()
>>>>>>> merge_empty_state

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
        listView = BreweryListView()
        view.addSubview(listView!)
        listView?.tableView.dataSource = self
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
>>>>>>> merge_empty_state
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
                self?.breweries = breweries
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryListCell", for: indexPath) as? BreweryListTableViewCell else { fatalError("Cannot create a cell") }
        
        let brewery = breweries[indexPath.row]
    
        cell.profileLetter.text = String(describing: brewery.name.first)
        
        return cell
    }
}
