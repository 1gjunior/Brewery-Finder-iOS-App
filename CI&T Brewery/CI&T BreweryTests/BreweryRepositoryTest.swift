//
//  BreweryRepositoryTest.swift
//  CI&T BreweryTests
//
//  Created by Rafaela Cristina Souza dos Santos on 20/09/22.
//

import XCTest
@testable import CI_T_Brewery

class BreweryRepositoryTest: XCTestCase {
    var repository: BreweryRepositoryProtocol!
    let apiManagerMock = APIManagerMock()
    let breweries = BreweryMock.breweries
    let brewery = BreweryMock.breweries[0]
    let photos = BreweryMock.breweryPhotos
    let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Error"])
    
    override func setUp() {
        repository = BreweryRepository(apiManager: apiManagerMock)
    }
    
    override func tearDown() {
        repository = nil
    }
    
    func test_topTenSuccess() {
        // given
        apiManagerMock.item = breweries
        
        // when
        repository.getTop10Breweries { result in
            // then
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail("Error test_topTenSuccess BreweryRepositoryTest")
            }
        }
    }
    
    func test_topTenError() {
        // given
        apiManagerMock.error = error
        
        // when
        repository.getTop10Breweries { result in
            // then
            switch result {
            case .success:
                XCTFail("Error test_topTenError BreweryRepositoryTest")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func test_getBreweryByIdSuccess() {
        // given
        apiManagerMock.item = brewery
        
        // when
        repository.getBreweryBy(id: "alphabet-city-brewing-co-new-york") { result in
            // then
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail("Error test_getBreweryByIdSuccess BreweryRepositoryTest")
            }
        }
    }
    
    func test_getBreweryByIdError() {
        // given
        apiManagerMock.error = error
        
        // when
        repository.getBreweryBy(id: "alphabet-city-brewing-co-new-york") { result in
            // then
            switch result {
            case .success:
                XCTFail("Error test_getBreweryByIdError BreweryRepositoryTest")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func test_getRatedBreweriesSuccess() {
        // given
        apiManagerMock.item = breweries
        
        // when
        repository.getRatedBreweries(email: "teste@teste.com") { result in
            // then
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail("Error test_getRatedBreweriesSuccess BreweryRepositoryTest")
            }
        }
    }
    
    func test_getRatedBreweriesError() {
        // given
        apiManagerMock.error = error
        
        // when
        repository.getRatedBreweries(email: "teste@teste.com") { result in
            // then
            switch result {
            case .success:
                XCTFail("Error test_getRatedBreweriesError BreweryRepositoryTest")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func test_getBreweryPhotosSuccess() {
        // given
        apiManagerMock.item = photos
        
        // when
        repository.getBreweryPhotos(id: "alphabet-city-brewing-co-new-york") { result in
            // then
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail("Error test_getBreweryPhotosSuccess BreweryRepositoryTest")
            }
        }
    }
    
    func test_getBreweryPhotosError() {
        // given
        apiManagerMock.error = error
        
        // when
        repository.getBreweryPhotos(id: "alphabet-city-brewing-co-new-york") { result in
            // then
            switch result {
            case .success:
                XCTFail("Error test_getBreweryPhotosError BreweryRepositoryTest")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
