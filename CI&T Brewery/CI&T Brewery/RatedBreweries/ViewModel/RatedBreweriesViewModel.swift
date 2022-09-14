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
enum RatedBreweriesViewModelState {
	 case initial
	 case loading
	 case success(breweries: [Brewery])
	 case emptyError
}

enum SortedRatedBreweries {
	 case sortedName
	 case sortedRating
}

class RatedBreweriesViewModel {
    let repository: BreweryRepositoryProtocol
    @Published private(set) var fieldsState: FieldsState = .blank
	 @Published private(set) var state: RatedBreweriesViewModelState = .initial
    
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
	public var sortedBreweries: SortedBreweries = .sortedName {
		willSet(newType) {
			  switch state{
			  case .success(let breweries):
					state = .success(breweries: breweriesSorted(breweries: breweries, type: newType))
			  default:
					break
			  }
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
