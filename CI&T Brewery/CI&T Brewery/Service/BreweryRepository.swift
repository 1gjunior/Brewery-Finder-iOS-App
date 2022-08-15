//
//  BreweryRepository.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 15/08/22.
//

import Foundation

protocol BreweryRepositoryProtocol {
    func getBreweriesBy(city by_city: String, completion: @escaping (Result<[Brewery], Error>) -> Void)
}

class BreweryRepository: BreweryRepositoryProtocol {
    private let apiManager: APIManagerService
    
    init(apiManager: APIManagerService = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getBreweriesBy(city by_city: String, completion: @escaping (Result<[Brewery], Error>) -> Void) {
        let url = URL(string: BreweryAPIService.getBreweriesURLString(city: by_city))!
        
        apiManager.fetchItems(url: url) { (result: Result<[Brewery], Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
