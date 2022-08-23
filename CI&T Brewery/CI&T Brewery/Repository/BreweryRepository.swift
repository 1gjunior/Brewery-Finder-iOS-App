//
//  BreweryRepository.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 15/08/22.
//

import Foundation

protocol BreweryRepositoryProtocol {
    func getBreweriesBy(city by_city: String, completion: @escaping (Result<[Brewery], Error>) -> Void)
    func getBreweryBy(id: String, completion: @escaping (Result<Brewery, Error>) -> Void)
    func postBreweryEvaluation(evaluation: BreweryEvaluation, completion: @escaping (Result<ApiEvaluationResponse, NetworkError>) -> Void)
    func getTop10Breweries(completion: @escaping (Result<[Brewery], Error>) -> Void)
    func getRatedBreweries(email: String, completion: @escaping (Result<[Brewery], Error>) -> Void)
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
    
    func postBreweryEvaluation(evaluation: BreweryEvaluation, completion: @escaping (Result<ApiEvaluationResponse, NetworkError>) -> Void) {
        
        apiManager.postItem(request: evaluation) { (result: Result<ApiEvaluationResponse, NetworkError>) in
            switch result {
            case .success(let data):
                print("repository bom")
                completion(.success(data))
            case .failure(let error):
                print("repository ruim")
                completion(.failure(error))
            }
        }
    }
    
    func getTop10Breweries(completion: @escaping (Result<[Brewery], Error>) -> Void) {
        guard let url = BreweryAPIService.getTop10BreweriesURLString() else { return }
        
        apiManager.fetchItems(url: url) { (result: Result<[Brewery], Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):

                completion(.failure(error))
            }
        }
    }
    
    func getRatedBreweries(email: String, completion: @escaping (Result<[Brewery], Error>) -> Void) {
        guard let url = BreweryAPIService.getRatedBrewerisByEmail(email: email) else { return }
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

