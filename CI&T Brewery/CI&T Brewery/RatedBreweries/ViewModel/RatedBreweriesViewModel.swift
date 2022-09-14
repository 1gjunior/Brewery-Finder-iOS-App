//
//  RatedBreweriesViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 13/09/22.
//

import Foundation

enum FillEmailState {
    case blank
    case invalid
    case valid
}

enum RatedBreweriesState {
    case initial
    case loading
    case success(breweries: [Brewery])
    case emptyError
}

class RatedBreweriesViewModel {
    let repository: BreweryRepositoryProtocol
    
    @Published private(set) var state: RatedBreweriesState = .initial
    @Published private(set) var fieldsState: FieldsState = .blank
    
    init(repository: BreweryRepository = BreweryRepository()) {
        self.repository = repository
    }
    
    func fetchRatedBreweries(email: String) {
        state = .loading
        print(state)
//        repository.getRatedBreweries { [weak self] result in
//            switch result {
//            case .failure(_):
//                self?.state = .emptyError
//            case .success(let breweriesResponse):
//                self?.state = .success(breweries: breweriesResponse)
//            }
//        }
    }
    
    public func fieldsValidation(emailText: String) {
        if !emailText.isEmpty && !emailText.isEmail() {
            fieldsState = .invalid
        } else if emailText.isEmail() {
            fieldsState = .valid
        } else {
            fieldsState = .blank
        }
    }
}
