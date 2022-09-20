//
//  FavoriteManager.swift
//  CI&T BreweryTests
//
//  Created by Pedro Henrique Catanduba de Andrade on 20/09/22.
//

import Foundation
@testable import CI_T_Brewery

class FavoriteManagerMock: FavoriteBreweriesManagerProtocol {
    func loadFavoriteBreweries() -> [CI_T_Brewery.FavoriteBreweries]? {
        return nil
    }
    
    func deleteFavoriteBreweries(id: String) {
            
    }
    
    func saveFavoriteBrewery(brewery: CI_T_Brewery.Brewery) {
        
    }
    
    func getAllBreweries() -> [CI_T_Brewery.FavoriteBreweries] {
        return .init()
    }
    
    func getBrewery(with id: String) -> CI_T_Brewery.FavoriteBreweries? {
        return nil
    }
}
