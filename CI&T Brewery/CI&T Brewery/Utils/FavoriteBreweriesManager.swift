//
//  BreweryManager.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 12/09/22.
//

import Foundation
import CoreData
import UIKit

protocol FavoriteBreweriesManagerProtocol {
	func loadFavoriteBreweries(with context: NSManagedObjectContext)
	func deleteFavoriteBreweries(id: String, context: NSManagedObjectContext)
}

class FavoriteBreweriesManager: FavoriteBreweriesManagerProtocol {
	static let shared = FavoriteBreweriesManager()
    var favoriteBreweries: [String : FavoriteBreweries] = [:]
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private init() {
        loadFavoriteBreweries(with: appDelegate.persistentContainer.viewContext)
    }
    
    func getContext() -> NSManagedObjectContext {
        let context = appDelegate.persistentContainer.viewContext
        
        return context
    }
    
    private func saveContext() {
        appDelegate.saveContext()
    }
	
	func loadFavoriteBreweries(with context: NSManagedObjectContext) {
		let fetchRequest: NSFetchRequest<FavoriteBreweries> = FavoriteBreweries.fetchRequest()
		do {
            try context.fetch(fetchRequest).forEach { brewery in
                addFavoriteBrewery(brewery)
            }
		} catch  {
			fatalError("Unresolved error \(error)")
		}
	}
	
	func deleteFavoriteBreweries(id: String, context: NSManagedObjectContext) {
        guard let brewery = favoriteBreweries[id] else { return }
        removeFavoriteBrewery(id)
		context.delete(brewery)
		do {
			try context.save()
		} catch {
			fatalError("Unresolved error \(error)")
		}
	}
    
    func saveFavoriteBrewery(brewery: Brewery) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteBreweries", in: context) else { return }
        let newFavoriteBrewery = NSManagedObject(entity: entity, insertInto: context)
        newFavoriteBrewery.setValue(brewery.id, forKey: "id")
        newFavoriteBrewery.setValue(brewery.name, forKey: "name")
        newFavoriteBrewery.setValue(brewery.sizeEvaluations, forKey: "evaluation")
        newFavoriteBrewery.setValue(brewery.type, forKey: "type")
        
        guard let newBrewery = newFavoriteBrewery as? FavoriteBreweries else { return }
        
        addFavoriteBrewery(newBrewery)
        
        saveContext()
    }
    
    func addFavoriteBrewery(_ brewery: FavoriteBreweries) {
        if let id = brewery.id {
            favoriteBreweries[id] = brewery
        }
    }
    
    func removeFavoriteBrewery(_ id: String) {
        favoriteBreweries[id] = nil
    }
}
