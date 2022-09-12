//
//  AppDelegate.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 11/08/22.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.yellowDark()
        let proxy = UINavigationBar.appearance()
        proxy.standardAppearance = appearance
        proxy.scrollEdgeAppearance = appearance
        
        return true
    }
	
	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
		 let container = NSPersistentContainer(name: "CITModel")
		 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			  if let error = error as NSError? {
				  // Replace this implementation with code to handle the error appropriately.
				  // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
					fatalError("Unresolved error \(error), \(error.userInfo)")
			  }
		 })
		 return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
		 let context = persistentContainer.viewContext
		 if context.hasChanges {
			  do {
					try context.save()
			  } catch {
					// Replace this implementation with code to handle the error appropriately.
					// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
					let nserror = error as NSError
					fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			  }
		 }
	}
}

