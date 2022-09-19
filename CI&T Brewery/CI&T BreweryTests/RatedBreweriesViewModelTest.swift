//
//  CI_T_BreweryTests.swift
//  CI&T BreweryTests
//
//  Created by Pedro Henrique Catanduba de Andrade on 11/08/22.
//

import XCTest
@testable import CI_T_Brewery

class RatedBreweriesViewModelTests: XCTestCase {
    
    var viewModel: RatedBreweriesViewModel!
    var repository: BreweryRepositoryMock!

    override func setUp() {
        repository = .init()
        viewModel = RatedBreweriesViewModel(repository: repository)
    }
    
    func testFetchRatedBreweries() {
        viewModel.fetchRatedBreweries(email: "")
        XCTAssert(viewModel.state == .emptyError)
        
        viewModel.fetchRatedBreweries(email: "test@test.com")
        XCTAssert(viewModel.state == .success(breweries: repository.breweries))
        
        repository.breweries = []
        viewModel.fetchRatedBreweries(email: "test@test.com")
        XCTAssert(viewModel.state == .emptyError)
    }
    
    func testFieldsValidation() {
        viewModel.fieldsValidation(emailText: "")
        XCTAssert(viewModel.fieldsState == .blank)
        
        viewModel.fieldsValidation(emailText: "123@.")
        XCTAssert(viewModel.fieldsState == .invalid)
        
        viewModel.fieldsValidation(emailText: "test@test.com")
        XCTAssert(viewModel.fieldsState == .valid)
    }
    
    func testBreweriesSorted() {
        viewModel.sortedBreweries = .sortedName
        XCTAssert(viewModel.state == .initial)
        
        viewModel.fetchRatedBreweries(email: "test@test.com")
        viewModel.sortedBreweries = .sortedName
        let sortedByName = repository.breweries.sorted(by: {$0.name < $1.name})
        XCTAssert(viewModel.state == .success(breweries: sortedByName))
        
        viewModel.sortedBreweries = .sortedRating
        let sortedByRating = repository.breweries.sorted(by: {$0.average < $1.average})
        XCTAssert(viewModel.state == .success(breweries: sortedByRating))
    }
}

