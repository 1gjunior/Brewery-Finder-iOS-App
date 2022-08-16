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

    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sinkBreweries()
        getBreweriesBy(city: "New York")
    }
    
    private func getBreweriesBy(city: String) {
        viewModel.fetchBreweriesBy(city: city)
    }
    
    private func sinkBreweries() {
        viewModel.$state.sink { state in
            switch state {
            case .initial:
                print("initial")
            case .success(let breweries):
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

