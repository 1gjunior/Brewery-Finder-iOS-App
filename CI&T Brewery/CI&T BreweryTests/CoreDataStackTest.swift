////
////  CoreDataStackTest.swift
////  CI&T BreweryTests
////
////  Created by Ramon Queiroz dos Santos on 22/09/22.
////
//
import Foundation
import CoreData
import CI_T_Brewery



class CoreDataTestStack {

	 let persistentContainer: NSPersistentContainer
	 let backgroundContext: NSManagedObjectContext
	 let mainContext: NSManagedObjectContext

	 init() {
		  persistentContainer = NSPersistentContainer(name: "CITModel")
		  let description = persistentContainer.persistentStoreDescriptions.first
		  description?.type = NSInMemoryStoreType

		  persistentContainer.loadPersistentStores { description, error in
				guard error == nil else {
					 fatalError("was unable to load store \(error!)")
				}
		  }

		  mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		  mainContext.automaticallyMergesChangesFromParent = true
		  mainContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator

		  backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
		  backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		  backgroundContext.parent = self.mainContext
	 }
}
