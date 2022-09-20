//
//  FavoriteBreweryUseCaseTest.swift
//  CI&T BreweryTests
//
//  Created by Rafaela Cristina Souza dos Santos on 19/09/22.
//

import XCTest
import Combine
@testable import CI_T_Brewery

class FavoriteBreweryUseCaseTest: XCTestCase {
    var useCase: FavoriteBreweriesUseCase!
    let repository = BreweryRepositoryMock()
    let manager = FavoriteBreweriesManagerMock()
    let breweries = BreweryMock.breweries
    
    override func setUp() {
        useCase = FavoriteBreweriesUseCase(manager: manager, repository: repository)
    }
    
    override func tearDown() {
        useCase = nil
    }
    
    // MARK: Top 10
    func test_TopTenBrewerySuccess() {
        // given
        repository.breweries = breweries
        
        // when
        useCase.fetchTop10Breweries { result in
            // then
            XCTAssertEqual(result, .success(breweries: self.breweries))
        }
    }
    
    func test_TopTenBreweryError() {
        // given
        repository.error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Error"])
        
        // when
        useCase.fetchTop10Breweries { result in
            // then
            XCTAssertEqual(result, .genericError)
        }
    }
}
