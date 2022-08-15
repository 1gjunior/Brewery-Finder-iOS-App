//
//  ViewController.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 11/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()

    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
        viewModel.fetchBreweriesBy(city: "new york")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

