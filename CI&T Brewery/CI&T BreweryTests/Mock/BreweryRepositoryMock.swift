//
//  BreweryRepositoryMock.swift
//  CI&T BreweryTests
//
//  Created by Pamella Victoria Soares Lima on 19/09/22.
//

import Foundation
@testable import CI_T_Brewery

class BreweryRepositoryMock: BreweryRepositoryProtocol {
    var breweries = BreweryMock.breweries
    var brewery: Brewery!
    var photos: [BreweryPhotos] = []
    var error: Error!
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
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(brewery))
        }
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
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(breweries))
        }
    }
    
    func getBreweryPhotos(id: String, completion: @escaping (Result<[BreweryPhotos], Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(photos))
        }
    }
    
    var apiEvaluationResponse = ApiEvaluationResponse(email: "Pam00@gmail.com", breweryId: "goat-ridge-brewing-new-london", evaluationGrade: 4.5)
}
