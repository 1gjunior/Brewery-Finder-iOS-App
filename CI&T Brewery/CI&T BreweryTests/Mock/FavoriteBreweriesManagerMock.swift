//
//  FavoriteBreweriesManagerMock.swift
//  CI&T BreweryTests
//
//  Created by Rafaela Cristina Souza dos Santos on 19/09/22.
//

import Foundation
@testable import CI_T_Brewery

class FavoriteBreweriesManagerMock: FavoriteBreweriesManagerProtocol {
    func addFavoriteBrewery(_ brewery: FavoriteBreweries) {
        
    }
    
    func removeFavoriteBrewery(_ id: String) {
        
    }
    
    func loadFavoriteBreweries() -> [FavoriteBreweries]? {
        return nil
    }
    
    func deleteFavoriteBreweries(id: String) {
        
    }
    
    func saveFavoriteBrewery(brewery: Brewery) {
        
    }
    
    func getAllBreweries() -> [FavoriteBreweries] {
        return .init()
    }
    
    func getBrewery(with id: String) -> FavoriteBreweries? {
        return nil
    }
}
