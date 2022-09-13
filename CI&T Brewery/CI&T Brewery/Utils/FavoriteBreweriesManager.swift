//
//  BreweryManager.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 12/09/22.
//

import Foundation
import CoreData

protocol FavoriteBreweriesManagerProtocol {
	func loadFavoriteBreweries(with context: NSManagedObjectContext)
	func deleteFavoriteBreweries(index: Int, context: NSManagedObjectContext)
}

class FavoriteBreweriesManager: FavoriteBreweriesManagerProtocol {
	static let shared = FavoriteBreweriesManager()
	var favoriteBreweries: [FavoriteBreweries] = []
	
	func loadFavoriteBreweries(with context: NSManagedObjectContext){
		let fetchRequest: NSFetchRequest<FavoriteBreweries> = FavoriteBreweries.fetchRequest()
		do {
			favoriteBreweries = try context.fetch(fetchRequest)
		} catch  {
			fatalError("Unresolved error \(error)")
		}
	}
	
	func deleteFavoriteBreweries(index: Int, context: NSManagedObjectContext) {
		let breweries = favoriteBreweries[index]
		context.delete(breweries)
		do {
			try context.save()
		} catch {
			fatalError("Unresolved error \(error)")
		}
	}
}
