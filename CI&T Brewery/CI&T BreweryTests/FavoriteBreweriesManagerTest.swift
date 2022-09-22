//
//  FavoriteBreweriesViewModelTest.swift
//  CI&T BreweryTests
//
//  Created by Ramon Queiroz dos Santos on 21/09/22.
//

import XCTest
@testable import CI_T_Brewery
import CoreData

class FavoriteBreweriesManagerTest: XCTestCase {
	
	var favoriteManager: FavoriteBreweriesManagerProtocol!
	var coreDataStack: CoreDataTestStack!
	
	 override func setUp() {
		 super.setUp()
		 coreDataStack = CoreDataTestStack()
		 favoriteManager = FavoriteBreweriesManager(context: coreDataStack.mainContext)

	 }

	func testCreateBrewerySuccess() {
		favoriteManager.saveFavoriteBrewery(brewery: Brewery(id: "aaaaa", name: "aaaaa", type: "test", street: "test",
																							address2: "test", address3: "test", city: "test", state: "test",
									  postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
									  website: "test", phone: "test", average: 1.0, sizeEvaluations: 0.0, photos: ["aaaa"]))
		let favorite = favoriteManager.getBrewery(with: "aaaaa")
		XCTAssertEqual("aaaaa", favorite?.name)
	}
	func testGetBrewerySuccess() {
		favoriteManager.saveFavoriteBrewery(brewery: Brewery(id: "bbbb", name: "bbbb", type: "test", street: "test",
																							address2: "test", address3: "test", city: "test", state: "test",
									  postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
									  website: "test", phone: "test", average: 1.0, sizeEvaluations: 0.0, photos: ["aaaa"]))
		let favorite = favoriteManager.getBrewery(with: "bbbb")
		XCTAssertNotNil(favorite)
		XCTAssertEqual("bbbb", favorite?.id)
	}
	func testgetBreweryError() {
		favoriteManager.saveFavoriteBrewery(brewery: Brewery(id: "cccc", name: "cccc", type: "test", street: "test",
																			  address2: "test", address3: "test", city: "test", state: "test",
									postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
									website: "test", phone: "test", average: 1.0, sizeEvaluations: 0.0, photos: ["aaaa"]))
		let favorite = favoriteManager.getBrewery(with: "abcd")
		XCTAssertNil(favorite)
	}
	func testDeleteBrewerySuccess() {
		favoriteManager.saveFavoriteBrewery(brewery: Brewery(id: "dddd", name: "dddd", type: "test", street: "test",
																							address2: "test", address3: "test", city: "test", state: "test",
									  postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
									  website: "test", phone: "test", average: 1.0, sizeEvaluations: 0.0, photos: ["aaaa"]))
		favoriteManager.deleteFavoriteBreweries(id: "dddd")
		let favorite = favoriteManager.getBrewery(with: "dddd")
		XCTAssertNil(favorite)
	}
}
