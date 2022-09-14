//
//  BreweryManager.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 12/09/22.
//

import Foundation
import CoreData

protocol FavoriteBreweriesManagerProtocol {
    func loadFavoriteBreweries() -> [FavoriteBreweries]?
    func deleteFavoriteBreweries(index: Int)
    func getAllBreweries() -> [FavoriteBreweries]
}

class FavoriteBreweriesManager: FavoriteBreweriesManagerProtocol {
    var favoriteBreweries: [FavoriteBreweries] = []
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func loadFavoriteBreweries() -> [FavoriteBreweries]? {
        let fetchRequest: NSFetchRequest<FavoriteBreweries> = FavoriteBreweries.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        }
        catch  {
            fatalError()
        }
    }
    
    func getAllBreweries() -> [FavoriteBreweries] {
        return favoriteBreweries
    }
    
    func deleteFavoriteBreweries(index: Int) {
        let breweries = favoriteBreweries[index]
        self.context.delete(breweries)
        do {
             try context.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
}
