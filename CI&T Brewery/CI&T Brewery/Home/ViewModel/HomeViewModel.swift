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
    let useCase: FavoriteBreweriesUseCase
    @Published private(set) var state: HomeViewModelState = .initial
    @Published private(set) var top10BreweriesState: HomeViewModelState = .initial
    public var sortedBreweries: SortedBreweries = .sortedName {
       willSet(newType){
            switch state{
            case .success(let breweries):
                state = .success(breweries: useCase.breweriesSorted(breweries: breweries, type: newType ))
            default:
                break
            }
        }
    }
    
    init(useCase: FavoriteBreweriesUseCase) {
        self.useCase = useCase
    }
    
    func fetchBreweriesBy(city: String) {
        state = .loading
        useCase.fetchBreweriesBy(city: city, type: sortedBreweries) { [weak self] state in
            self?.state = state
        }
    }
    
    func fetchTop10Breweries() {
        top10BreweriesState = .loading
        
        useCase.fetchTop10Breweries { [weak self] state in
            self?.top10BreweriesState = state
        }
    }
    
    func saveFavorite(brewery: Brewery) {
        useCase.handleFavoriteBrewery(brewery)
    }
    
    func loadFavoriteBreweries() {
        useCase.loadBreweries()
    }
    
    func getFavoriteButtonState(with id: String) -> FavoriteButtonState {
        var state: FavoriteButtonState = .unselected
        
        if useCase.manager.getBrewery(id: id) != nil {
            state = .selected
        } else {
            state = .unselected
        }
        
        return state
    }
    
    func favoriteButtonTapped(brewery: Brewery, state: FavoriteButtonState) -> FavoriteButtonState {
        var state = state
        if state == .unselected {
            state = .selected
        } else {
            state = .unselected
        }
        
        saveFavorite(brewery: brewery)
        
        return state
    }
}
