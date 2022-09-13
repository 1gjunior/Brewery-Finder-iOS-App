//
//  App+Injection.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 15/08/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        
        register { APIManager() as APIManagerService }
        
        // MARK: - Repositories
        register { BreweryRepository(apiManager: resolve()) as BreweryRepositoryProtocol }
        
        // MARK: - ViewModels
        register { HomeViewModel() }
        register { BreweryDetailViewModel()}
        register { RatingViewModel() }
        register { FavoriteBreweriesViewModel() }
        register { RatedBreweriesViewModel() }
    }
}
