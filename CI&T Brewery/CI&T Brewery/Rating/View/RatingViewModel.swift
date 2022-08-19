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
    
    @Published private(set) var stateRating: RatingViewModelState = .initial
    
    func post(){
            repository.postBreweryEvaluation(evaluation: uploadBreweryEvaluation) {[weak self] response in
                switch response {
                case .failure(_):
                    print("error")
                case .success(_):
                    print("foi")
                }
            }
        }
        let uploadBreweryEvaluation = BreweryEvaluation(email: "c3510201@mail.com", breweryId: "1st-republic-brewing-co-essex-junction", evaluationGrade: 1)
    }
}
