//
//  RatedBreweriesViewController.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 13/09/22.
//

import Foundation
import UIKit
import Resolver

class RatedBreweriesViewController: UIViewController {
    @Injected var viewModel: RatedBreweriesViewModel
    
    //    private lazy var breweryList: FavoriteListView = {
    //        let breweryList = FavoriteListView(frame: CGRect(x: 0.0, y: 400.0, width: 400.0, height: 300.0))
    //        breweryList.translatesAutoresizingMaskIntoConstraints = false
    //
    //        return breweryList
    //
    //    }()
    
    init() {
        super.init(nibName: "RatedBreweriesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension RatedBreweriesViewController {
    private func setupNavigationBar() {
        let lbNavTitle = UILabel(frame: CGRect(x: 0, y: 40, width: 320, height: 40))
        lbNavTitle.textAlignment = .left
        lbNavTitle.text = NSLocalizedString("ratedNavigationTitle", comment: "")
        lbNavTitle.textColor = .breweryBlack()
        lbNavTitle.font = UIFont.robotoRegular(ofSize: 22)
        
        self.navigationItem.titleView = lbNavTitle
        self.navigationController?.navigationBar.tintColor = .black
    }
}
