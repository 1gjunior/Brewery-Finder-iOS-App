//
//  APIManagerServiceMock.swift
//  CI&T BreweryTests
//
//  Created by Rafaela Cristina Souza dos Santos on 20/09/22.
//

import Foundation
@testable import CI_T_Brewery

class APIManagerMock: APIManagerService {
    var fetchItemsHandler: ((URL, Any) -> Void)?
    var error: Error! = nil
    var item: Any!
    
    func fetchItems<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if let fetchItemsHandler = fetchItemsHandler {
            fetchItemsHandler(url, completion)
        }
        
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(item as! T))
        }
    }
    
    func postItem<T, R>(request: T, completion: @escaping (Result<R, NetworkError>) -> Void) where T : Decodable, T : Encodable, R : Decodable {
        
    }
    
    func postPhoto<T, R>(id: String, imageData: Data, request: T, completion: @escaping (Result<R, NetworkError>) -> Void) where T : Decodable, T : Encodable, R : Decodable {
        
    }
}
