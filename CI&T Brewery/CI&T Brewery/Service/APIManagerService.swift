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
    func postPhoto<T: Codable, R: Decodable>(id: String, imageData: Data, request: T, completion: @escaping (Result<R, NetworkError>) -> Void)
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
            .map{$0.data}
            .decode(type: R.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                case .failure:
                    completion(.failure(.requestError))
                case .finished: break
                }
            }, receiveValue: { (result) in
                completion(.success(result))
            })
            .store(in: &subscribers)
    }
    
    func postPhoto<T: Codable, R: Decodable>(id: String, imageData: Data, request: T, completion: @escaping (Result<R, NetworkError>) -> Void) {
        guard let url = BreweryAPIService.postPhotosURLString(id: id) else { return }
        let boundary = FormatRequestPhoto.generateBoundaryString()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = FormatRequestPhoto.createBodyWithParameters(filePathKey: "file", imageDataKey: imageData, boundary: boundary)
        URLSession.shared.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: R.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                case .failure:
                    completion(.failure(.requestError))
                    print("resultCompletion \(resultCompletion)")
                case .finished: break
                }
            }, receiveValue: { (result) in
                completion(.success(result))
                print("result \(result)")
            })
            .store(in: &subscribers)
    }
}

