//
//  CoreDataService.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 14/09/22.
//

import Foundation
import CoreData

class CoreDataService {
    
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init() {
         persistentContainer = {
            let container = NSPersistentContainer(name: "CITModel")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        mainContext = persistentContainer.viewContext
    }
}
    
