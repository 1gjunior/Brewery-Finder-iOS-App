//
//  RatedBreweriesViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 13/09/22.
//

import Foundation
import Combine

enum FillEmailState {
    case blank
    case invalid
    case valid
}

enum SortedRatedBreweries {
	 case sortedName
	 case sortedRating
}

enum RatedBreweriesState: Equatable {
    case initial
    case loading
    case success(breweries: [Brewery])
    case emptyError
}

class RatedBreweriesViewModel {
    private let repository: BreweryRepositoryProtocol
    
    @Published private(set) var state: RatedBreweriesState = .initial
    @Published private(set) var fieldsState: FieldsState = .blank
    
    public var sortedBreweries: SortedBreweries = .sortedName {
        willSet(newType) {
            print("CHAMOU sortedBreweries")
              switch state{
              case .success(let breweries):
                    state = .success(breweries: breweriesSorted(breweries: breweries, type: newType))
              default:
                    break
              }
         }
    }
    
    init(repository: BreweryRepositoryProtocol = BreweryRepository()) {
        self.repository = repository
    }
    
    func fetchRatedBreweries(email: String) {
        repository.getRatedBreweries(email: email) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.state = .emptyError
            case .success(let breweriesResponse):
                if breweriesResponse.count > 0 {
                    self?.state = .success(breweries: breweriesResponse)
                }
                else {
                    self?.state = .emptyError
                }
            }
        }
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
    
	func breweriesSorted(breweries: [Brewery], type: SortedBreweries) -> [Brewery] {
		 switch type  {
		 case .sortedName:
		  return breweries.sorted(by: {$0.name < $1.name})
		 case .sortedRating:
		  return breweries.sorted(by: {$0.average < $1.average})
		 }
	}
}
