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
        guard let url = BreweryAPIService.getBreweriesURLString(city: by_city) else { return }
        
        apiManager.fetchItems(url: url) { (result: Result<[Brewery], Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getBreweryBy(id: String, completion: @escaping (Result<Brewery, Error>) -> Void) {
        guard let url = BreweryAPIService.getBreweryURLString(id: id) else { return }
        
        apiManager.fetchItems(url: url) { (result: Result<Brewery, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func postBreweryEvaluation(completion: @escaping (Result<sendBreweryEvaluation, Error>) -> Void){
        guard let url = BreweryAPIService.postBreweryEvaluationURLString() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        apiManager.postItem(request: request) { (result: Result<sendBreweryEvaluation, Error>) in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
