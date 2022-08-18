//
//  BreweryDetailViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation

class BreweryDetailViewModel {
    let repository: BreweryRepository
    
    init(repository: BreweryRepository = BreweryRepository()) {
        self.repository = repository
    }
    
    func post(){
        repository.postBreweryEvaluation { response in
            switch response {
            case .failure(_):
                print("error")
            case .success(_):
                print("sucesso")
            }
        }
    }
}
