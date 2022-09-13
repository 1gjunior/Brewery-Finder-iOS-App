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
        guard let brewery = brewery else {return}
        let ratingViewController = RatingViewController(breweryObject: brewery, id: id)
        ratingViewController.dismissActionBreweryDetail =  updateRatedBrewery
        present(ratingViewController, animated: true, completion: nil)
    }
    
    private func updateRatedBrewery() {
        getRatedBreweries(id: id)
    }
    
    
    @IBAction func openMapButton(_ sender: Any) {
        guard let brewery = brewery,
        let breweryLatitude = brewery.latitute,
        let breweryLongitude = brewery.longitude
        else {return}
        OpenMapDirections.present(in: self, sourceView: view, latitude: breweryLatitude, longitude: breweryLongitude)
    }
    
    private func sucessRatedBrewery() {
        getBreweryBy(id: id)
        avaliacaoBotao.isHidden = true
        heightDataView.constant = heightDataView.constant + 40
        ratedBreweryView.isHidden = false
        let sucessTitle = NSLocalizedString("ratedBrewery", comment: "")
        ratedBreweryView.ratedBreweryLabel.text = sucessTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBreweryBy(id: id)
        sinkBrewery()
        sinkRatedBrewery()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
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
                self?.showAlreadyRatedView()
            case .noEvaluated:
                self?.showRatingButton()
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
    
    private func showAlreadyRatedView() {
        DispatchQueue.main.async {[weak self] in
            self?.sucessRatedBrewery()
        }
    }
    
    private func showRatingButton() {
        DispatchQueue.main.async {[weak self] in
            self?.avaliacaoBotao.isHidden = false
        }
    }
    
    internal func getRatedBreweries(id: String) {
        viewModel.checkRatingByBrewery(id: id)
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

