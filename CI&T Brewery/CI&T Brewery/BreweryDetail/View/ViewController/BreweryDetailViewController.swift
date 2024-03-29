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
import Kingfisher
import Cosmos

class BreweryDetailViewController: UIViewController {
    @Injected var viewModel: BreweryDetailViewModel
    var dismissAction: (() -> ())?
    private var brewery: BreweryObject?
    private var breweryPhotos: [BreweryPhotos] = []
    var lastEmail: String?
    private var cancellables: Set<AnyCancellable> = []
    let id: String
    
    // MARK: Outlets
    @IBOutlet weak var viewTitle: UILabel! {
        didSet {
            viewTitle.font = UIFont.robotoRegular(ofSize: 24)
            viewTitle.textColor = UIColor.breweryBlack()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var dataView: UIView! {
        didSet {
            dataView.layer.cornerRadius = 30
        }
    }
    
    @IBOutlet weak var logo: UILabel! {
        didSet {
            logo.makeRoundLabel()
        }
    }
    
    @IBOutlet weak var name: UILabel! {
        didSet {
            name.font = UIFont.quicksandBold(ofSize: 16)
            name.textColor = UIColor.breweryBlack()
            name.showsExpansionTextWhenTruncated = true
        }
    }
    
    @IBOutlet weak var type: UILabel! {
        didSet {
            type.font = UIFont.quicksandRegular(ofSize: 14)
            type.textColor = UIColor.breweryBlack()
        }
    }
    
    @IBOutlet weak var evaluation: UILabel! {
        didSet {
            evaluation.font = UIFont.quicksandRegular(ofSize: 14)
            evaluation.textColor = UIColor.breweryBlackLight()
        }
    }
    
    @IBOutlet weak var average: UILabel! {
        didSet {
            average.font = UIFont.quicksandMedium(ofSize: 14)
            average.textColor = UIColor.breweryBlack()
        }
    }
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    @IBOutlet weak var websiteStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: websiteStackView)
        }
    }
    
    @IBOutlet weak var website: UILabel! {
        didSet {
            website.font = UIFont.robotoLight(ofSize: 14)
            website.textColor = UIColor.breweryBlack()
        }
    }
    
    @IBOutlet weak var addressStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: addressStackView)
        }
    }
    
    @IBOutlet weak var address: UILabel! {
        didSet {
            address.font = UIFont.robotoLight(ofSize: 14)
            address.textColor = UIColor.breweryBlack()
            
        }
    }
    
    @IBOutlet weak var mapStackView: UIStackView! {
        didSet {
            addBottomSeparator(uiStackView: mapStackView)
        }
    }
    
    @IBOutlet weak var mapText: UIButton! {
        didSet {
            let attrs = [
                NSAttributedString.Key.font: UIFont.robotoMedium(ofSize: 14),
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.foregroundColor: UIColor.breweryBlack()
            ] as [NSAttributedString.Key : Any]
            let attrString = NSMutableAttributedString(string: NSLocalizedString("seeOnMap", comment: ""), attributes:attrs)
            mapText.setAttributedTitle(attrString, for: .normal)
            // alinha o texto completamente a esquerda
            mapText.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                mapText.titleLabel!.leadingAnchor.constraint(equalTo: mapText.leadingAnchor),
                mapText.titleLabel!.trailingAnchor.constraint(equalTo: mapText.trailingAnchor),
                mapText.titleLabel!.topAnchor.constraint(equalTo: mapText.topAnchor),
                mapText.titleLabel!.bottomAnchor.constraint(equalTo: mapText.bottomAnchor)
            ])
        }
    }
    
    @IBOutlet weak var addPhotoButton: UIButton! {
        didSet {
            addPhotoButton.layer.borderColor = UIColor.breweryBlack().cgColor
            addPhotoButton.layer.borderWidth = 1
            addPhotoButton.layer.cornerRadius = 18
        }
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        present(PhotosViewController(id: id, completion: onDismissAddPhotoView), animated: true)
    }
    
    func onDismissAddPhotoView() {
        getBreweryPhotos()
    }
    
    @IBOutlet weak var evaluateBreweryButton: UIButton! {
        didSet {
            evaluateBreweryButton?.layer.borderColor = UIColor.breweryYellowLight().cgColor
            evaluateBreweryButton?.layer.borderWidth = 1
            evaluateBreweryButton?.layer.cornerRadius = 18
            evaluateBreweryButton?.layer.backgroundColor = UIColor.breweryYellowLight().cgColor
        }
    }
    
    @IBOutlet weak var ratedBreweryView: RatedBreweryView!
    
    @IBOutlet weak var heightDataView: NSLayoutConstraint!
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    init(id: String) {
        self.id = id
        super.init(nibName: "BreweryDetailViewController", bundle: nil)
        viewModel.id = id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        getBrewery()
        sinkBrewery()
        sinkRatedBrewery()
        sinkPhotos()
        getBreweryPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        getRatedBreweries()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let dismissAction = dismissAction else {return}
        dismissAction()
    }
    
    // MARK: Actions
    @IBAction func goToRatingView(_ sender: Any) {
        guard let brewery = brewery else {return}
        let ratingViewController = RatingViewController(breweryObject: brewery, id: id)
        ratingViewController.dismissActionBreweryDetail =  updateRatedBrewery
        present(ratingViewController, animated: true, completion: nil)
    }
    
    @IBAction func favorite(_ sender: UIButton) {
        guard let brewery = brewery else { return }
        
        sender.isSelected.toggle()
        
        viewModel.handleFavoriteBrewery(brewery: brewery.brewery)
    }
    
    @IBAction func fadeButtonTouchDown(sender: UIButton) {
        sender.isHighlighted = false
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: [.curveLinear,
                      .allowUserInteraction,
                      .beginFromCurrentState],
            animations: {
                sender.alpha = 0.75
            }, completion: nil)
    }
    
    @IBAction func fadeButtonTouchUpInside(sender: UIButton) {
        sender.isHighlighted = false
        sender.alpha = 1
    }
    
    @IBAction func openMapButton(_ sender: Any) {
        guard let brewery = brewery,
              let breweryLatitude = brewery.latitute,
              let breweryLongitude = brewery.longitude
        else {return}
        OpenMapDirections.present(in: self, sourceView: view, latitude: breweryLatitude, longitude: breweryLongitude)
    }
    
    private func addBottomSeparator(uiStackView: UIStackView) {
        uiStackView.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.breweryGrayLight(), thickness: 1.0)
    }
    
    private func configure(_ brewery: BreweryObject) {
        name.text = brewery.name
        logo.text = brewery.logo
        type.text = brewery.type
        evaluation.text = String(brewery.evaluation)
        average.text = String(brewery.average)
        website.text = brewery.website
        address.text = brewery.address
        cosmosView.rating = floor(brewery.average)
        
        if !viewModel.isWebsiteAvailable(brewery: brewery) {
            websiteStackView.isHidden = true
            addressStackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20).isActive = true
            heightDataView.constant = heightDataView.constant - 30
        }
        
        if !viewModel.isCoordinationAvailable(brewery: brewery) {
            mapStackView.isHidden = true
            photoCollectionView.topAnchor.constraint(equalTo: addressStackView.bottomAnchor, constant: 15).isActive = true
            heightDataView.constant = heightDataView.constant - 40
        }
    }
    
    private func sinkBrewery() {
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .success(let brewery):
                self?.successState(brewery)
            case .error:
                print("error")
            case .none: break
            }
        }.store(in: &cancellables)
    }
    
    private func sinkRatedBrewery() {
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
    
    private func sinkPhotos() {
        viewModel.breweriePhotosSubsject
            .sink(receiveCompletion: { _ in } ) { (result) in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.breweryPhotos = result
                    self.photoCollectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateRatedBrewery() {
        getRatedBreweries()
    }
    
    private func sucessRatedBrewery() {
        getBrewery()
        evaluateBreweryButton.isHidden = true
        heightDataView.constant = heightDataView.constant + 80
        ratedBreweryView.isHidden = false
        let sucessTitle = NSLocalizedString("ratedBrewery", comment: "")
        ratedBreweryView.ratedBreweryLabel.text = sucessTitle
    }
    
    private func successState(_ brewery: BreweryObject) {
        DispatchQueue.main.async { [weak self] in
            self?.brewery = brewery
            self?.configure(brewery)
        }
    }
    
    private func showAlreadyRatedView() {
        DispatchQueue.main.async {[weak self] in
            self?.sucessRatedBrewery()
        }
    }
    
    private func showRatingButton() {
        DispatchQueue.main.async {[weak self] in
            self?.evaluateBreweryButton.isHidden = false
        }
    }
    
    internal func getRatedBreweries() {
        viewModel.checkRatingByBrewery()
    }
    
    private func getBrewery() {
        viewModel.fetchBrewery()
    }
    
    private func getBreweryPhotos() {
        viewModel.fetchPhotosByBrewery()
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.photoCollectionView.reloadData()
        }
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
        
        let logoIcon = UIButton(type: .system)
        logoIcon.setImage(UIImage(named: "icon_back"), for: .normal)
        logoIcon.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoIcon)
        logoIcon.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Find or Invite", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    private func setupRightNavigationBar() {
        let favoriteButton = UIButton()
        favoriteButton.isSelected = viewModel.getButtonIsFavorited(with: id)
        favoriteButton.setImage(UIImage(named: "favorite_border_fill")?.withRenderingMode(.alwaysOriginal), for: .selected)
        favoriteButton.setImage(UIImage(named: "favorite_border")?.withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favorite(_:)), for: .touchUpInside)
        
        let shareIcon = UIButton(type: .system)
        shareIcon.setImage(UIImage(named: "icon_share")?.withRenderingMode(.alwaysOriginal), for: .normal)
        shareIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: favoriteButton)
        ]
    }
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BreweryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        breweryPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = breweryPhotos[indexPath.row]
        let url = URL(string: item.url)!
        cell.photo.kf.setImage(with: url)
        
        return cell
    }
}
