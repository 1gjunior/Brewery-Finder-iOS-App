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
    
    func test_fetchBrewerySuccess() {
        // given
        repository.brewery = brewery
        viewModel.id = "alphabet-city-brewing-co-new-york"
        
        // when
        viewModel.fetchBrewery()
        
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
    
    func test_fetchBreweryError() {
        // given
        repository.error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Error"])
        viewModel.id = "alphabet-city-brewing-co-new-york"
        
        // when
        viewModel.fetchBrewery()
        
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
    
    func test_checkRatingByBreweryEvaluatedSuccess() {
        // given
        let email = "test@test.com"
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        viewModel.id = "aaaaa"
        
        do {
            try email.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
        
        // when
        viewModel.checkRatingByBrewery()
        
        // then
        viewModel.$stateRatedBrewery
            .sink(
                receiveCompletion: { result in
                    XCTFail("Error test_checkRatingByBreweryEvaluatedSuccess BreweryDetailViewModelTest")
                },
                receiveValue: { result in
                    XCTAssertEqual(result, .evaluated)
                }
            )
            .store(in: &cancellables)
    }
    
    func test_checkRatingByBreweryNotEvaluatedSuccess() {
        // given
        let email = "test@test.com"
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        
        do {
            try email.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
        
        // when
        viewModel.checkRatingByBrewery()
        
        // then
        viewModel.$stateRatedBrewery
            .sink(
                receiveCompletion: { result in
                    XCTFail("Error test_checkRatingByBreweryNotEvaluatedSuccess BreweryDetailViewModelTest")
                },
                receiveValue: { result in
                    XCTAssertEqual(result, .noEvaluated)
                }
            )
            .store(in: &cancellables)
    }
    
    func test_checkRatingByBreweryError() {
        // given
        let email = "error@test.com"
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        
        do {
            try email.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
        
        // when
        viewModel.checkRatingByBrewery()
        
        // then
        viewModel.$stateRatedBrewery
            .sink(
                receiveCompletion: { result in
                    XCTFail("Error test_checkRatingByBrewerySuccess BreweryDetailViewModelTest")
                },
                receiveValue: { result in
                    XCTAssertNil(result)
                }
            )
            .store(in: &cancellables)
    }
    
    func test_isWebsiteAvailableSuccess() {
        XCTAssertEqual(viewModel.isWebsiteAvailable(brewery: breweryObject), true)
    }
    
    func test_isCoordinationAvailableSuccess() {
        XCTAssertEqual(viewModel.isCoordinationAvailable(brewery: breweryObject), true)
    }
    
    func test_getLastEmailSuccess() {
        // given
        let email = "teste@gmail.com"
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        
        // when
        do {
            try email.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
        
        let lastEmail = viewModel.getLastEmail()
        
        // then
        XCTAssertEqual(email, lastEmail)
    }
    
    func test_getLastEmailError() {
        // given
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        
        // when
        do {
            try FileManager.default.removeItem(atPath: fileURL.path)
        }
        catch {
            print("Error writing")
        }
        
        let lastEmail = viewModel.getLastEmail()
        
        // then
        XCTAssertNil(lastEmail)
    }
    
    func test_fetchPhotosByBrewerySuccess() {
        // given
        let photos = BreweryMock.breweryPhotos
        repository.photos = photos
        viewModel.id = "alphabet-city-brewing-co-new-york"
        
        // when
        viewModel.fetchPhotosByBrewery()
        
        // then
        viewModel.breweriePhotosSubsject
            .sink(
                receiveCompletion: {_ in
                    XCTFail("Error test_fetchPhotosByBrewerySuccess BreweryDetailViewModelTest")
                },
                receiveValue: { result in
                    XCTAssertEqual(result, photos)
                }
            )
            .store(in: &cancellables)
    }
    
    func test_fetchPhotosByBreweryError() {
        // given
        repository.error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Error"])
        viewModel.id = "alphabet-city-brewing-co-new-york"
        
        // when
        viewModel.fetchPhotosByBrewery()
        
        // then
        viewModel.breweriePhotosSubsject
            .sink(
                receiveCompletion: {result in
                    XCTAssertNotNil(result)
                },
                receiveValue: { _ in
                    XCTFail("Error test_fetchPhotosByBreweryError BreweryDetailViewModelTest")
                }
            )
            .store(in: &cancellables)
    }
}
