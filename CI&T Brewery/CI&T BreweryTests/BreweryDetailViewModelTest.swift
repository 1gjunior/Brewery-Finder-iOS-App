//
//  BreweryDetailViewModelTest.swift
//  CI&T BreweryTests
//
//  Created by Rafaela Cristina Souza dos Santos on 20/09/22.
//

import XCTest
import Combine
@testable import CI_T_Brewery

class BreweryDetailViewModelTest: XCTestCase {
    var viewModel: BreweryDetailViewModel!
    var cancellables: Set<AnyCancellable>!
    let repository = BreweryRepositoryMock()
    let breweryObject = BreweryMock.breweryObject
    let brewery = BreweryMock.breweries[0]
    
    override func setUp() {
        cancellables = []
        viewModel = BreweryDetailViewModel(repository: repository)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func test_fetchBreweryByIdSuccess() {
        // given
        repository.brewery = brewery
        
        // when
        viewModel.fetchBreweryBy(id: "alphabet-city-brewing-co-new-york")
        
        // then
        viewModel.$state
            .sink(
                receiveCompletion: {_ in
                    XCTFail("Error test_fetchBreweryByIdSuccess BreweryDetailViewModelTest")
                },
                receiveValue: { result in
                    XCTAssertEqual(result, .success(brewery: self.breweryObject))
                }
            )
            .store(in: &cancellables)
    }
    
    func test_fetchBreweryByIdError() {
        // given
        repository.error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Error"])
        
        // when
        viewModel.fetchBreweryBy(id: "alphabet-city-brewing-co-new-york")
        
        // then
        viewModel.$state
            .sink(
                receiveCompletion: { result in
                    XCTFail("Error test_fetchBreweryByIdError BreweryDetailViewModelTest")
                },
                receiveValue: { result in
                    XCTAssertEqual(result, .error)
                }
            )
            .store(in: &cancellables)
    }
    
    func test_getLastEmailSuccess() {
        let email = "teste@gmail.com"
        
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        do {
            try email.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
        
        let lastEmail = viewModel.getLastEmail()
        XCTAssertEqual(email, lastEmail)
    }
    
    func test_getLastEmailError() {
        let email = ""
        
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        do {
            try email.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
        
        let lastEmail = viewModel.getLastEmail()
        XCTAssertNil(lastEmail)
    }
}
