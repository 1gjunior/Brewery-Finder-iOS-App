//
//  SearchBreweryTest.swift
//  CI&T BreweryTests
//
//  Created by Pedro Henrique Catanduba de Andrade on 18/09/22.
//

import Foundation
import XCTest
@testable import CI_T_Brewery

class SearchBreweryTest: XCTestCase {
    
    var viewModel: HomeViewModel!
    var repository: BreweryRepositoryMock!
    var useCase: FavoriteBreweriesUseCase!
    
    override func setUp() {
        useCase = .init(manager: FavoriteBreweriesManagerMock(), repository: BreweryRepositoryMock())
        viewModel = HomeViewModel(useCase: useCase)
    }
    
    func testFetchBreweriesSucess() {
        viewModel.fetchBreweriesBy(city: "new york")
        XCTAssert(viewModel.state == .success(breweries: repository.breweries))
    }
    
    func testFetchBreweriesEmptyError() {
        viewModel.fetchBreweriesBy(city: "")
        XCTAssert(viewModel.state == .emptyError)
        
    }
    
    func testFetchBreweriesFailure() {
        viewModel.fetchBreweriesBy(city: "failure")
        XCTAssert(viewModel.state == .genericError)
    }
}
