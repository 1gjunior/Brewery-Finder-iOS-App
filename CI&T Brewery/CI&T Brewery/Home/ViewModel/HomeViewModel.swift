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
    
    let repository: BreweryRepository
    @Published private(set) var state: HomeViewModelState = .initial
    
    init(repository: BreweryRepository = BreweryRepository()) {
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
}
