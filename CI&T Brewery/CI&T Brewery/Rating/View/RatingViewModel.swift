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
    
    func post(evaluation: BreweryEvaluation){
        repository.postBreweryEvaluation(evaluation: evaluation) {[weak self] response in
            switch response {
            case .failure(_):
                print("ERRO RATING VIEW MODEL")
                self?.stateRating = .error
            case .success(_):
                print("foi")
                self?.stateRating = .sucess
            }
        }
    }
    
    public func saveUserEmailInFileStorage(emailText: String) {
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        do {
            try emailText.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
    }
}

