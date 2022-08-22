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

protocol ShowRatedBreweryDelegate: AnyObject {
    func showView(wasSucess: Bool)
}

class BreweryDetailViewController: UIViewController, ShowRatedBreweryDelegate, UINavigationControllerDelegate {
    
    private var brewery: BreweryObject?
    
    func showView(wasSucess: Bool) {
        self.wasSucesso = wasSucess
        if self.wasSucesso == true {
            sucessRatedBrewery()
        }
    }
    
    var wasSucesso: Bool?
    @IBOutlet weak var ratedBreweryView: RatedBreweryView!
    @IBOutlet weak var heightDataView: NSLayoutConstraint!
    @IBOutlet weak var avaliacaoBotao: UIButton! {
        didSet {
            avaliacaoBotao!.layer.borderColor = UIColor.breweryYellowLight().cgColor
            avaliacaoBotao!.layer.borderWidth = 1
            avaliacaoBotao!.layer.cornerRadius = 18
            avaliacaoBotao!.layer.backgroundColor = UIColor.breweryYellowLight().cgColor
        }
    }
    
    @Injected var viewModel: BreweryDetailViewModel
    private var cancellables: Set<AnyCancellable> = []
    let id: String
    
    init(id: String) {
        self.id = id
        super.init(nibName: "BreweryDetailView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func goToRatingView(_ sender: Any) {
        let ratingViewController = RatingViewController(id: id)
        ratingViewController.delegate = self
        present(ratingViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func openMapButton(_ sender: Any) {
        OpenMapDirections.present(in: self, sourceView: view, latitude: brewery?.latitute ?? 0, longitude: brewery?.longitude ?? 0)
    }
    
    private func sucessRatedBrewery() {
        avaliacaoBotao.isHidden = true
        heightDataView.constant = heightDataView.constant + 20
        ratedBreweryView.isHidden = false
        ratedBreweryView.ratedBreweryLabel.text = "Você já avaliou essa \ncervejaria"
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
            self?.brewery = brewery
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

