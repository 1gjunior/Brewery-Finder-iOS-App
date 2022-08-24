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


class BreweryDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    var dismissAction: (() -> ())?
    private var brewery: BreweryObject?
    private var breweryDetailView: BreweryDetailView?
    var lastEmail: String?
    @IBOutlet weak var ratedBreweryView: RatedBreweryView!
    @IBOutlet weak var heightDataView: NSLayoutConstraint!
    @IBOutlet weak var avaliacaoBotao: UIButton! {
        didSet {
            avaliacaoBotao?.layer.borderColor = UIColor.breweryYellowLight().cgColor
            avaliacaoBotao?.layer.borderWidth = 1
            avaliacaoBotao?.layer.cornerRadius = 18
            avaliacaoBotao?.layer.backgroundColor = UIColor.breweryYellowLight().cgColor
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
        let ratingViewController = RatingViewController(breweryObject: brewery!, id: id)
        ratingViewController.dismissActionBreweryDetail =  updateRatedBrewery
        present(ratingViewController, animated: true, completion: nil)
    }
    
    private func updateRatedBrewery() {
        getRatedBreweries(id: id)
    }
    
    
    @IBAction func openMapButton(_ sender: Any) {
        guard let brewery = brewery else {return}
        OpenMapDirections.present(in: self, sourceView: view, latitude: brewery.latitute, longitude: brewery.longitude)
    }
    
    private func sucessRatedBrewery() {
        getBreweryBy(id: id)
        avaliacaoBotao.isHidden = true
        heightDataView.constant = heightDataView.constant + 40
        ratedBreweryView.isHidden = false
        ratedBreweryView.ratedBreweryLabel.text = "Você já avaliou essa \ncervejaria"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        getBreweryBy(id: id)
        sinkBrewery()
        sinkRatedBrewery()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRatedBreweries(id: id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let dismissAction = dismissAction else {return}
        dismissAction()
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
    
    public func sinkRatedBrewery() {
        viewModel.$stateRatedBrewery.sink { [weak self] state in
            switch state {
            case .evaluated:
                self?.successStateRated()
            case .noEvaluated:
                print("não avaliada")
            case .none:
                break
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
    
    private func successStateRated() {
        DispatchQueue.main.async {[weak self] in
            self?.sucessRatedBrewery()
        }
    }
    
    internal func getRatedBreweries(id: String) {
        viewModel.fetchRatedBreweryBy(id: id)
    }
    
    private func getBreweryBy(id: String) {
        viewModel.fetchBreweryBy(id: id)
    }
}

extension BreweryDetailViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor.yellowDark()
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
        
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: logoIcon)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    private func setupRightNavigationBar() {
        let favoriteIcon = UIButton(type: .system)
        favoriteIcon.setImage(UIImage(named: "favorite_border")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let shareIcon = UIButton(type: .system)
        shareIcon.setImage(UIImage(named: "icon_share")?.withRenderingMode(.alwaysOriginal), for: .normal)
        shareIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: favoriteIcon), UIBarButtonItem(customView: shareIcon)]
    }
}

