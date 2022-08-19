//
//  RatingViewModel.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 18/08/22.
//

import Foundation

enum RatingViewModelState {
    case initial
    case sucess
    case error
}

class RatingViewModel {
    
    let repository: BreweryRepository
    @Published private(set) var stateRating: RatingViewModelState = .initial
    
    init(repository: BreweryRepository = BreweryRepository()) {
        self.repository = repository
    }
    
    func post(){
        repository.postBreweryEvaluation(evaluation: uploadBreweryEvaluation) {[weak self] response in
            switch response {
            case .failure(_):
                print("error")
                self?.stateRating = .error
            case .success(_):
                print("foi")
                self?.stateRating = .sucess
            }
        }
    }
    
    let uploadBreweryEvaluation = BreweryEvaluation(email: "c3510201@mail.com", breweryId: "1st-republic-brewing-co-essex-junction", evaluationGrade: 1)
}

