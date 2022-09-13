//
//  FavoriteViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 12/09/22.
//

import Foundation
import Combine

enum FavoriteViewModelState {
    case initial
    case loading
    case success(breweries: [Brewery])
    case emptyError
    case genericError
}

enum SortedFavoriteBreweries {
    case sortedName
    case sortedRating
}

class FavoriteViewModel {
    @Published private(set) var state: FavoriteViewModelState = .initial
    
    public var sortedBreweries: SortedBreweries = .sortedName {
       willSet(newType){
            switch state{
            case .success(let breweries):
                state = .success(breweries: breweriesSorted(breweries: breweries, type: newType ))
            default:
                break
            }
        }
    }
    
    func breweriesSorted(breweries: [Brewery], type: SortedBreweries) -> [Brewery] {
        switch type  {
        case .sortedName:
         return  breweries.sorted(by: {$0.name < $1.name})
        case .sortedRating:
         return  breweries.sorted(by: {$0.average < $1.average})
        }
    }
}
