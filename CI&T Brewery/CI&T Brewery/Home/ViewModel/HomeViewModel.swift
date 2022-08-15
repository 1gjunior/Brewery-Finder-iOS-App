//
//  BreweryViewModel.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 15/08/22.
//

import Foundation
import Combine

class HomeViewModel {
    let repository = BreweryRepository()
    @Published private(set) var breweries: [Brewery] = []
    
    func fetchBreweriesBy(city: String) {
        repository.getBreweriesBy(city: city) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let breweriesResponse):
                self?.breweries = breweriesResponse
            }
        }
    }
}
