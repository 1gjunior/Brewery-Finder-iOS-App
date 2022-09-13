//
//  FavoriteViewController.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 12/09/22.
//

import Foundation
import UIKit
import Resolver

class FavoriteViewController: UIViewController {
    @Injected var viewModel: FavoriteViewModel
    var breweries: [Brewery] = []
    
    private lazy var breweryList: FavoriteListView = {
        let breweryList = FavoriteListView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
        breweryList.translatesAutoresizingMaskIntoConstraints = false
        return breweryList
    }()
    
    init() {
        super.init(nibName: "FavoriteViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuccessState(breweries)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupSuccessState(_ breweries: [Brewery])  {
        view.addSubview(breweryList)
        constrainBreweryList()
        breweryList.update(breweries)
    }
    
    private func constrainBreweryList() {
        breweryList.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        breweryList.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        breweryList.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        breweryList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}

extension FavoriteViewController: FavoriteListViewDelegate {
    func didSorted(type: SortType) {
        switch type {
        case .sortedName:
            viewModel.sortedBreweries = .sortedName
        case .sortedRating:
            viewModel.sortedBreweries = .sortedRating
        }
    }
}

extension FavoriteViewController {
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
