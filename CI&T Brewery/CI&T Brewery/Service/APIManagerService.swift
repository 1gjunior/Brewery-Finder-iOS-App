//
//  APIManagerService.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 15/08/22.
//

import Foundation
import Combine

protocol APIManagerService {
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
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
}
