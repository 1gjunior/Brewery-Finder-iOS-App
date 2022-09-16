//
//  FavoriteBreweriesUseCase.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 14/09/22.
//

import Foundation

protocol FavoriteBreweriesUseCaseProtocol {
    func handleFavoriteBrewery(_ brewery: Brewery)
    func loadBreweries()
}

class FavoriteBreweriesUseCase: FavoriteBreweriesUseCaseProtocol {
    private let manager: FavoriteBreweriesManagerProtocol
    private let repository: BreweryRepositoryProtocol
    
    init(manager: FavoriteBreweriesManagerProtocol, repository: BreweryRepositoryProtocol = BreweryRepository()) {
        self.manager = manager
        self.repository = repository
    }
    
    func fetchBreweriesBy(city: String, type: SortedBreweries, completion: @escaping ((HomeViewModelState) -> ())) {
        if !city.isEmpty {
            repository.getBreweriesBy(city: city) { result in
                switch result {
                case .failure(_):
                    completion(.genericError)
                case .success(let breweriesResponse):
                    completion(.success(breweries: self.breweriesSorted(breweries: breweriesResponse, type: type)))
                }
            }
        } else {
           completion(.emptyError)
        }
    }
    
    func fetchTop10Breweries(completion: @escaping ((HomeViewModelState) -> ())) {
        repository.getTop10Breweries { result in
            switch result {
            case .failure(_):
                completion(.genericError)
            case .success(let breweriesResponse):
                completion(.success(breweries: breweriesResponse))
            }
        }
    }
    
    func breweriesSorted(breweries:[Brewery], type: SortedBreweries) -> [Brewery]{
        switch type  {
        case .sortedName:
         return  breweries.sorted(by: {$0.name < $1.name})
        case .sortedRating:
         return  breweries.sorted(by: {$0.average < $1.average})
        }
    }
    
    func handleFavoriteBrewery(_ brewery: Brewery) {
        if let id = manager.getBrewery(with: brewery.id)?.id {
            manager.deleteFavoriteBreweries(id: id)
        } else {
            manager.saveFavoriteBrewery(brewery: brewery)
        }
    }
    
    func loadBreweries() {
        _ = manager.loadFavoriteBreweries()
    }
    
    func getBrewery(with id: String) -> FavoriteBreweries? {
        return manager.getBrewery(with: id)
    }
    
}
