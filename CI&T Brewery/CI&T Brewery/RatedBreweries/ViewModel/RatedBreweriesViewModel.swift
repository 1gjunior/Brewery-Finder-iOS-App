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

class RatedBreweriesViewModel {
    let repository: BreweryRepositoryProtocol
    @Published private(set) var fieldsState: FieldsState = .blank
    
    init(repository: BreweryRepository = BreweryRepository()) {
        self.repository = repository
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
