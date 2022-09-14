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
    let manager: FavoriteBreweriesManagerProtocol
    
    init(manager: FavoriteBreweriesManagerProtocol) {
        self.manager = manager
    }
    
    func handleFavoriteBrewery(_ brewery: Brewery) {
        if let id = manager.getBrewery(id: brewery.id)?.id {
            manager.deleteFavoriteBreweries(id: id)
        } else {
            manager.saveFavoriteBrewery(brewery: brewery)
        }
    }
    
    func loadBreweries() {
        _ = manager.loadFavoriteBreweries()
    }
    
}
