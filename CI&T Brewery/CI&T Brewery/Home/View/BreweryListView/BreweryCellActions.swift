//
//  BreweryCellActions.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 12/09/22.
//

import Foundation

class BreweryCellActions: BreweryCellActionsProtocol {
    let select: ((String) -> ())
    let favorite: ((String) -> ())
    
    
    init(onSelect: @escaping (_ id: String) -> (), onFavorite: @escaping (_ id: String) -> ()) {
        self.select = onSelect
        self.favorite = onFavorite
    }
    
    func onSelect(id: String) {
        select(id)
    }
    
    func onFavorite(id: String) {
        favorite(id)
    }
}

protocol BreweryCellActionsProtocol {
    func onSelect (id: String) -> ()
    func onFavorite (id: String) -> ()
}
