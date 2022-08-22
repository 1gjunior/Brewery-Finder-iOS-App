//
//  BreweryDetailViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation

enum BreweryDetailViewModelState {
    case success(brewery: BreweryObject)
}

class BreweryDetailViewModel {
    let repository: BreweryRepository
    @Published private(set) var state: BreweryDetailViewModelState?

    init(repository: BreweryRepository = BreweryRepository()) {
        self.repository = repository
    }

    func fetchBreweryBy(id: String) {
        repository.getBreweryBy(id: id) { [weak self] result in
            switch result {
                case .success(let breweryResponse):
                    let parsedBrewery = BreweryObject(brewery: breweryResponse)
                    self?.state = .success(brewery: parsedBrewery)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func checkMapData(brewery: BreweryObject) -> Bool {
        if (brewery.latitute == 0 && brewery.longitude == 0) {
           return false
        }
        return false
    }
}
