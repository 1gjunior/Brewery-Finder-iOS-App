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
            print("Teste \(result)")
//            XCTAssertEqual(result, .failure(result as! Error))
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
        apiManagerMock.error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Error"])
        
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
}
