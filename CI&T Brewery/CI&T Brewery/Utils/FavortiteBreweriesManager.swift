//
//  BreweryManager.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 12/09/22.
//

import Foundation
import CoreData

protocol FavortiteBreweriesManagerProtocol {
	func loadFavortiteBreweries(with context: NSManagedObjectContext)
	func deleteFavortiteBreweries(index: Int, context: NSManagedObjectContext)
}

class FavortiteBreweriesManager: FavortiteBreweriesManagerProtocol {
	static let shared = FavortiteBreweriesManager()
	var favortiteBreweries: [FavortiteBreweries] = []
	
	func loadFavortiteBreweries(with context: NSManagedObjectContext){
		let fetchRequest: NSFetchRequest<FavortiteBreweries> = FavortiteBreweries.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		do {
			favortiteBreweries = try context.fetch(fetchRequest)
		} catch  {
			print(error.localizedDescription)
		}
	}
	
	func deleteFavortiteBreweries(index: Int, context: NSManagedObjectContext) {
		let breweries = favortiteBreweries[index]
		context.delete(breweries)
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private init() {
		
	}
}
