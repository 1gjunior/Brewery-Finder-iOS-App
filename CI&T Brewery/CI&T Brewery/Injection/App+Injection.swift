//
//  App+Injection.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 15/08/22.
//

import Foundation
import Resolver
import CoreData

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        
        defaultScope = .graph
        
        register { APIManager() as APIManagerService }
        
        // MARK: - Repositories
        register { BreweryRepository(apiManager: resolve()) as BreweryRepositoryProtocol }
        
        // MARK: - ViewModels
        register { HomeViewModel(useCase: resolve()) }
        register { BreweryDetailViewModel() }
        register { RatingViewModel() }
        register { FavoriteBreweriesViewModel(useCase: resolve()) }
        let coreDataService = CoreDataService()
        register { FavoriteBreweriesManager(context: coreDataService.mainContext) as FavoriteBreweriesManagerProtocol}.scope(.application)
        register { FavoriteBreweriesUseCase(manager: resolve()) }
        register { RatedBreweriesViewModel() }
    }
}
