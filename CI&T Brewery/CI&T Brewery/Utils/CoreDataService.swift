//
//  CoreDataService.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 14/09/22.
//

import Foundation
import CoreData

class CoreDataService {
		 
		 static let shared = CoreDataService()
		 
		 let persistentContainer: NSPersistentContainer
		 let backgroundContext: NSManagedObjectContext
		 let mainContext: NSManagedObjectContext
		 
		  init() {
			  persistentContainer = NSPersistentContainer(name: "CITModel")
			  let description = persistentContainer.persistentStoreDescriptions.first
			  description?.type = NSSQLiteStoreType
			  
			  persistentContainer.loadPersistentStores { description, error in
					guard error == nil else {
						 fatalError("was unable to load store \(error!)")
					}
			  }
			  
			  mainContext = persistentContainer.viewContext
			  
			  backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
			  backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
			  backgroundContext.parent = self.mainContext
		 }
	}
    
