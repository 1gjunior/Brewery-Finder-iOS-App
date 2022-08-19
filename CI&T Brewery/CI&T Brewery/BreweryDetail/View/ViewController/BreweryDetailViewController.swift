//
//  BreweryDetailViewController.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation
import UIKit

class BreweryDetailViewController: UIViewController {
    
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
    
    init() {
        super.init(nibName: "BreweryDetailView", bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var breweryDetailView: BreweryDetailView = {
        let bdView = BreweryDetailView()
        bdView.translatesAutoresizingMaskIntoConstraints = false
        return bdView
    }()
    
   
    @IBAction func goToRatingView(_ sender: Any) {
        let ratingViewController = RatingViewController()
        let navigation = UINavigationController(rootViewController: ratingViewController)
        navigation.modalPresentationStyle = .pageSheet

        if let sheet = navigation.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 40
        }
        avaliacaoBotao.isHidden = true
        let antigaAltura = heightDataView.constant
        print("ANTIGA ALTURA \(antigaAltura)")
        heightDataView.constant = heightDataView.constant + 50
//        let novaAltura =  heightDataView.constant
//        print("NOVA ALTURA \(novaAltura)")
        ratedBreweryView.isHidden = false
        
        present(navigation, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        avaliacaoBotao.isHidden = true
        breweryDetailView.evaluateBreweryButton?.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        avaliacaoBotao.isHidden = true
        //breweryDetailView.evaluateBreweryButton?.isHidden = true
    }
    
    func hideButton() {
       // breweryDetailView.evaluateBreweryButton?.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        ratedBreweryView.ratedBreweryLabel.text = "Você já avaliou essa \ncervejaria"
    }
        
    // depois do fetch, chamar este metodo
    // a classe BreweryObject possui os campos formatados
    private func setViewData(brewery: BreweryObject) {
        print(brewery)
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
