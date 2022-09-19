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
	func getBreweryPhotos(id: String, completion: @escaping (Result<[BreweryPhotos], Error>) -> Void)
    func postPhotosByBrewery(imageData: Data, breweryId: String, completion: @escaping (Result<BreweryPhotos, Error>) -> Void)
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
                completion(.success(data))
            case .failure(let error):
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
	
	func getBreweryPhotos(id: String, completion: @escaping (Result<[BreweryPhotos], Error>) -> Void) {
		guard let url = BreweryAPIService.getPhotosByBrewery(id: id) else { return }
		
		apiManager.fetchItems(url: url) { (result: Result<[BreweryPhotos], Error>) in
			switch result {
			case .success(let data):
				completion(.success(data))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
    
    func postPhotosByBrewery(imageData: Data, breweryId: String, completion: @escaping (Result<BreweryPhotos, Error>) -> Void) {
        apiManager.postPhoto(id: breweryId, imageData: imageData, request: imageData) { (result: Result<BreweryPhotos, NetworkError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
                print("deu certo")
            case .failure(let error):
                completion(.failure(error))
                print("falhou")
            }
        }
    }
}


