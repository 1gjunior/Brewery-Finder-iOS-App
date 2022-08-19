//
//  BreweryDetailViewController.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation
import UIKit
import Combine
import Resolver

class BreweryDetailViewController: UIViewController {
    
    @Injected var viewModel: BreweryDetailViewModel
    private var cancellables: Set<AnyCancellable> = []
    var id: String = ""
    
    init() {
        super.init(nibName: "BreweryDetailView", bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func goToRatingView(_ sender: Any) {
        let ratingViewController = RatingViewController()
        ratingViewController.id = id
        let navigation = UINavigationController(rootViewController: ratingViewController)
        navigation.modalPresentationStyle = .pageSheet
        
        if let sheet = navigation.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 40
        }
        
        present(navigation, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        getBreweryBy(id: id)
        sinkBrewery()
    }
    
    private func sinkBrewery() {
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .success(let brewery):
                self?.successState(brewery)
            case .none: break
            }
        }.store(in: &cancellables)
    }
    
    private func successState(_ brewery: BreweryObject) {
        DispatchQueue.main.async { [weak self] in
            guard let view = self?.view as? BreweryDetailView else { return }
            view.configure(brewery)
        }
    }
    
    private func getBreweryBy(id: String) {
        viewModel.fetchBreweryBy(id: id)
    }
}

extension BreweryDetailViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 0.671, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        setupNavigationBarItems()
    }
    private func setupNavigationBarItems() {
        setupLeftNavigationBar()
        setupRightNavigationBar()
    }
    private func setupLeftNavigationBar() {
        let logoIcon = UIButton(type: .system)
        logoIcon.setImage(UIImage(named: "icon_back"), for: .normal)
        logoIcon.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoIcon)
    }
    private func setupRightNavigationBar() {
        let favoriteIcon = UIButton(type: .system)
        favoriteIcon.setImage(UIImage(named: "favorite_border")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let starIcon = UIButton(type: .system)
        starIcon.setImage(UIImage(named: "icon_share")?.withRenderingMode(.alwaysOriginal), for: .normal)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: favoriteIcon), UIBarButtonItem(customView: starIcon)]
    }
}
