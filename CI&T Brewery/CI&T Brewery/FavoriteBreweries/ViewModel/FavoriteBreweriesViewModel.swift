//
//  FavoriteBreweriesViewModel.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 12/09/22.
//

import Combine
import Foundation

enum FavoriteBreweriesViewModelState {
    case initial
    case empty
}

class FavoriteBreweriesViewModel {
    @Published private(set) var state: FavoriteBreweriesViewModelState = .empty
}
