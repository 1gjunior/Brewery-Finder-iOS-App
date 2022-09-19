//
//  HomeViewModelTest.swift
//  CI&T BreweryTests
//
//  Created by Rafaela Cristina Souza dos Santos on 19/09/22.
//

import XCTest
import Combine
@testable import CI_T_Brewery

class HomeViewModelTest: XCTestCase {
    var viewModel: HomeViewModel!
    var cancellables: Set<AnyCancellable>!
    let useCase = FavoriteBreweriesUseCaseMock()
    let breweries = BreweryMock.breweries
    
    override func setUp() {
        viewModel = HomeViewModel(useCase: useCase)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
    }

    // MARK: Top 10
    func test_TopTenBrewerySuccess() {
        // given
        useCase.breweryList = breweries
        
        // when
        viewModel.fetchTop10Breweries()
        
        // then
        viewModel.$top10BreweriesState
            .sink(
                receiveCompletion: { _ in
                    XCTFail("Error test_TopTenBrewerySuccess HomeViewModelTest")
                },
                receiveValue: { result in
                    XCTAssertEqual(result, .success(breweries: self.breweries))
                })
            .store(in: &cancellables)
    }
    
    func test_TopTenBreweryError() {
        // given
        useCase.error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Error"])
        
        // when
        viewModel.fetchTop10Breweries()
        
        // then
        viewModel.$top10BreweriesState
            .sink(
                receiveCompletion: { _ in
                    XCTFail("Error test_TopTenBreweryError HomeViewModelTest")
                },
                receiveValue: { result in
                    XCTAssertEqual(result, .genericError)
                })
            .store(in: &cancellables)
    }
}
