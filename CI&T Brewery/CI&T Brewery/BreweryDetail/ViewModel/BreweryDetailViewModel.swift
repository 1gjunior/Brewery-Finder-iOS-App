//
//  BreweryDetailViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation

enum BreweryDetailViewModelState {
    case initial
    case loading
    case success(brewery: BreweryObject)
    case genericError
}

class BreweryDetailViewModel {
    let repository: BreweryRepository
    @Published private(set) var state: BreweryDetailViewModelState = .initial
    
    init(repository: BreweryRepository = BreweryRepository()) {
        self.repository = repository
    }
    
    func fetchBreweryBy(id: String) {
        if !id.isEmpty {
            state = .loading
            
            repository.getBreweryBy(id: id) { [weak self] result in
                switch result {
                case .failure(_):
                    self?.state = .genericError
                case .success(let breweryResponse):
                    let parsedBrewery = BreweryObject(brewery: breweryResponse)
                    self?.state = .success(brewery: parsedBrewery)
                }
            }
        }
    }
}
