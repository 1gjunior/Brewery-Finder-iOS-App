//
//  BreweryViewModel.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 15/08/22.
//

import Foundation
import Combine

enum HomeViewModelState {
    case initial
    case loading
    case success(breweries: [Brewery])
    case emptyError
    case genericError
}

class HomeViewModel {
    var lastCity: String?
    let repository: BreweryRepositoryProtocol
    @Published private(set) var state: HomeViewModelState = .initial
    @Published private(set) var top10BreweriesState: HomeViewModelState = .initial
    
    init(repository: BreweryRepositoryProtocol = BreweryRepository()) {
        self.repository = repository
    }
    
    func fetchBreweriesBy(city: String) {        
        if !city.isEmpty {
            state = .loading
            
            repository.getBreweriesBy(city: city) {[weak self] result in
                switch result {
                case .failure(_):
                    self?.state = .genericError
                case .success(let breweriesResponse):
                    self?.state = .success(breweries: breweriesResponse)
                }
            }
        } else {
            state = .emptyError
        }
    }
    
    func fetchTop10Breweries() {
        top10BreweriesState = .loading
        
        repository.getTop10Breweries { [weak self] result in
            switch result {
            case .failure(_):
                self?.top10BreweriesState = .genericError
            case .success(let breweriesResponse):
                self?.top10BreweriesState = .success(breweries: breweriesResponse)
            }            
        }
    }
}
