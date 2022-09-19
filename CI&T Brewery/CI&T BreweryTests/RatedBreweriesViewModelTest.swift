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

class BreweryRepositoryMock: BreweryRepositoryProtocol {
    
    var networkError: NetworkError? = nil
    
    func postPhotosByBrewery(imageData: Data, breweryId: String, completion: @escaping (Result<BreweryPhotos, Error>) -> Void) {
    }
    
    func getRatedBreweries(email: String, completion: @escaping (Result<[Brewery], Error>) -> Void) {
        let emailTest = "test@test.com"
        let error = NSError(domain: "testing", code: 200)
        
        _ = emailTest == email ? completion(.success(breweries)) : completion(.failure(error))
    }
    
    func getBreweriesBy(city: String, completion: @escaping (Result<[Brewery], Error>) -> Void) {
        let error = NSError(domain: "testing", code: 200)
        if city == "new york" {
            completion(.success(breweries))
        } else if city == ""{
            completion(.success([]))
        } else {
            completion(.failure(error))
        }
    }
    
    func getBreweryBy(id: String, completion: @escaping (Result<Brewery, Error>) -> Void) {
        
    }
    
    func postBreweryEvaluation(evaluation: BreweryEvaluation, completion: @escaping (Result<ApiEvaluationResponse, NetworkError>) -> Void) {
        
        if networkError != nil {
            completion(.failure(networkError!))
        }
        else {
            completion(.success(apiEvaluationResponse))
        }
    }
    
    func getTop10Breweries(completion: @escaping (Result<[Brewery], Error>) -> Void) {
        
    }
    
    func getBreweryPhotos(id: String, completion: @escaping (Result<[BreweryPhotos], Error>) -> Void) {
        
    }
    
    var breweries = [
                      Brewery(id: "aaaaa", name: "aaaaa", type: "test", street: "test",
                      address2: "test", address3: "test", city: "test", state: "test",
                      postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
                      website: "test", phone: "test", average: 1.0, sizeEvaluations: 0.0, photos: nil),
        
                      Brewery(id: "fopsdk", name: "fopsdk", type: "test", street: "test",
                      address2: "test", address3: "test", city: "test", state: "test",
                      postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
                      website: "test", phone: "test", average: 1.0, sizeEvaluations: 0.0, photos: nil),
                      
                      Brewery(id: "ckasmplp", name: "ckasmplp", type: "test", street: "test",
                      address2: "test", address3: "test", city: "test", state: "test",
                      postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
                      website: "test", phone: "test", average: 0.0, sizeEvaluations: 0.0, photos: nil)
                    ]
    
    var apiEvaluationResponse = ApiEvaluationResponse(email: "Pam00@gmail.com", breweryId: "goat-ridge-brewing-new-london", evaluationGrade: 4.5)
}
