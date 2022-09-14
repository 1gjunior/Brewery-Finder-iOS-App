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
	func loadFavoriteBreweries() -> [FavoriteBreweries]?
	func deleteFavoriteBreweries(id: String)
    func saveFavoriteBrewery(brewery: Brewery)
    func getAllBreweries() -> [FavoriteBreweries]
    func getBrewery(id: String) -> FavoriteBreweries?
}

class FavoriteBreweriesManager: FavoriteBreweriesManagerProtocol {
    private var favoriteBreweries: [String : FavoriteBreweries] = [:]
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getBrewery(id: String) -> FavoriteBreweries? {
        return favoriteBreweries[id]
    }
    
    func getAllBreweries() -> [FavoriteBreweries] {
        return favoriteBreweries.values.sorted { _,_ in true }
    }
	
    func loadFavoriteBreweries() -> [FavoriteBreweries]? {
        let fetchRequest: NSFetchRequest<FavoriteBreweries> = FavoriteBreweries.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            
            result.forEach { brewery in
                addFavoriteBrewery(brewery)
            }
            
            return result
        }
        catch  {
            fatalError()
        }
    }
	
    func deleteFavoriteBreweries(id: String) {
        guard let breweries = favoriteBreweries[id] else { return }
        removeFavoriteBrewery(id)
        self.context.delete(breweries)
        do {
             try context.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func saveFavoriteBrewery(brewery: Brewery) {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteBreweries", in: context) else { return }
        let newFavoriteBrewery = NSManagedObject(entity: entity, insertInto: context)
        newFavoriteBrewery.setValue(brewery.id, forKey: "id")
        newFavoriteBrewery.setValue(brewery.name, forKey: "name")
        newFavoriteBrewery.setValue(brewery.sizeEvaluations, forKey: "evaluation")
        newFavoriteBrewery.setValue(brewery.type, forKey: "type")
        
        guard let newBrewery = newFavoriteBrewery as? FavoriteBreweries else { return }
        
        addFavoriteBrewery(newBrewery)
        
        do {
            try context.save()
        } catch let error {
            fatalError("Unresolved error \(error)")
        }
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
