//
//  CoreDataExtension.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 12/09/22.
//

import Foundation
import UIKit
import CoreData

extension UIViewController{
	var context: NSManagedObjectContext{
	
	let appDeleage = UIApplication.shared.delegate as! AppDelegate
		return appDeleage.persistentContainer.viewContext
		
	}
	
}
