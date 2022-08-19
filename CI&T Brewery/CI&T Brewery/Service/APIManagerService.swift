//
//  APIManagerService.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 15/08/22.
//

import Foundation
import Combine

enum NetworkError: Error {
    case responseError
    case requestError
}

protocol APIManagerService {
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
    func postItem <T: Codable, R: Decodable> (request: T, completion: @escaping (Result<R, NetworkError>) -> Void)
}

class APIManager: APIManagerService {
    
    private var subscribers = Set<AnyCancellable>()
    
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            }, receiveValue: { (result) in
                completion(.success(result))
            }).store(in: &subscribers)
    }
    
    func postItem<T: Codable, R: Decodable>(request: T, completion: @escaping (Result<R, NetworkError>) -> Void) {
        guard let url = BreweryAPIService.postBreweryEvaluationURLString() else { return }
        
        let jsonData = try? JSONEncoder().encode(request)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        URLSession.shared.dataTaskPublisher(for: request)
            .map{$0.response}
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                case .failure:
                    completion(.failure(.requestError))
                case .finished: break
                }
            }, receiveValue: {(result) in
                print("RESULT \(result)")
                if let result = result as? R{
                    print("RESULT API MANAGER\(result)")
                    completion(.success(result ))}
                else {
                    print("ERROR NO API MANAGER\(result)")
                    completion(.failure(.responseError))
                }
            })
            .store(in: &subscribers)
    }
}
