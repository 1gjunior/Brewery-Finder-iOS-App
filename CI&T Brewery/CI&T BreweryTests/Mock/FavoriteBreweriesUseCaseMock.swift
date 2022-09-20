//
//  FavoriteBreweriesUseCaseMock.swift
//  CI&T BreweryTests
//
//  Created by Rafaela Cristina Souza dos Santos on 19/09/22.
//

import Foundation
@testable import CI_T_Brewery

class FavoriteBreweriesUseCaseMock: FavoriteBreweriesUseCaseProtocol {
    
    func removeFavoriteBrewery(_ brewery: FavoriteBreweries) {
    }
    
    var breweryList: [Brewery] = []
    var error: Error! = nil
    var state: HomeViewModelState!
    
    func fetchTop10Breweries(completion: @escaping ((HomeViewModelState) -> ())) {
        if error != nil {
            completion(.genericError)
        } else {
            completion(.success(breweries: breweryList))
        }
    }
    
    func handleFavoriteBrewery(_ brewery: Brewery) {
        print()
    }

    func loadBreweries() {
        print()
    }
    
    func fetchBreweriesBy(city: String, type: SortedBreweries, completion: @escaping ((HomeViewModelState) -> ())) {
        
    }
    
    func breweriesSorted(breweries: [Brewery], type: SortedBreweries) -> [Brewery] {
        return []
    }
    
    func getBrewery(with id: String) -> FavoriteBreweries? {
        return .init()
    }
    
    func toggleFavoriteButtonState(_ state: FavoriteButtonState) -> FavoriteButtonState {
        return .selected
    }
    
    func getFavoriteButtonState(with id: String) -> FavoriteButtonState {
        return .selected
    }
}
