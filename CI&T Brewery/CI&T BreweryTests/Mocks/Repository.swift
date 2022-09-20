//
//  Repository.swift
//  CI&T BreweryTests
//
//  Created by Pedro Henrique Catanduba de Andrade on 20/09/22.
//

import Foundation
@testable import CI_T_Brewery

class BreweryRepositoryMock: BreweryRepositoryProtocol {
    
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
        
    }
    
    func getTop10Breweries(completion: @escaping (Result<[Brewery], Error>) -> Void) {
        
    }
    
    func getBreweryPhotos(id: String, completion: @escaping (Result<[BreweryPhotos], Error>) -> Void) {
        
    }
    
    func postPhotosByBrewery(imageData: Data, breweryId: String, completion: @escaping (Result<CI_T_Brewery.BreweryPhotos, Error>) -> Void) {
        
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
}
