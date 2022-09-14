//
//  FavoriteBreweriesViewModel.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 12/09/22.
//

import Combine
import Foundation
import Resolver

enum FavoriteBreweriesViewModelState {
    case initial
    case loading
    case success(breweries: [FavoriteBreweries])
    case emptyError
    case genericError
}

enum SortedFavoriteBreweries {
    case sortedName
    case sortedRating
}

class FavoriteBreweriesViewModel {
    
    @Published private(set) var state: FavoriteBreweriesViewModelState = .initial
    @Injected private var favoriteManager: FavoriteBreweriesManagerProtocol
    
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
    
    func breweriesSorted(breweries: [FavoriteBreweries], type: SortedBreweries) -> [FavoriteBreweries] {
        switch type  {
        case .sortedName:
            return breweries.sorted(by: {$0.name ?? "" < $1.name ?? ""})
        case .sortedRating:
            return breweries.sorted(by: {$0.evaluation < $1.evaluation})
        }
    }
    
    func fetchFavoriteBrewery() {
        let allBrewries = favoriteManager.getAllBreweries()
        if allBrewries.count > 0 {
            state = .success(breweries: allBrewries)
        }
        else {
            state = .emptyError
        }
    }
}
