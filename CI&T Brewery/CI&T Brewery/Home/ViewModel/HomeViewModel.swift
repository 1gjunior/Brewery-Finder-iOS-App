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

enum SortedBreweries{
    case sortedName
    case sortedRating
}

class HomeViewModel {
    
    let repository: BreweryRepositoryProtocol
    @Published private(set) var state: HomeViewModelState = .initial
    @Published private(set) var top10BreweriesState: HomeViewModelState = .initial
    public var sortedBreweries: SortedBreweries = .sortedName {
       willSet(newType){
            switch state{
            case .success(let breweries):
                state = .success(breweries: breweriesSorted(brewries: breweries, type: newType ))
            default:
                break
            }
        }
    }
    
    init(repository: BreweryRepositoryProtocol = BreweryRepository()) {
        self.repository = repository
    }
    
    func fetchBreweriesBy(city: String) {        
        if !city.isEmpty {
            state = .loading
            
            repository.getBreweriesBy(city: city) {[weak self] result in
                guard let self = self else {return}
                switch result {
                case .failure(_):
                    self.state = .genericError
                case .success(let breweriesResponse):
                    self.state = .success(breweries: self.breweriesSorted(brewries: breweriesResponse, type: self.sortedBreweries))
                }
            }
        } else {
            state = .emptyError
        }
    }
    
    func breweriesSorted(brewries:[Brewery], type: SortedBreweries) -> [Brewery]{
        switch type  {
        case .sortedName:
         return  brewries.sorted(by: {$0.name < $1.name})
        case .sortedRating:
         return  brewries.sorted(by: {$0.average < $1.average})
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
    
    //TODO: INTEGRATION WITH CORE DATA
    func favoriteBrewery(id: String) {
        print(id)
    }
}
