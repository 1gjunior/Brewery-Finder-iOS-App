//
//  BreweryDetailViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation

enum BreweryDetailViewModelState {
    case success(brewery: BreweryObject)
}

enum EvaluationState {
    case evaluated
    case noEvaluated
}


class BreweryDetailViewModel {
    let repository: BreweryRepository
    @Published private(set) var state: BreweryDetailViewModelState?
    @Published private(set) var stateRatedBrewery: EvaluationState?

    init(repository: BreweryRepository = BreweryRepository()) {
        self.repository = repository
    }

    func fetchBreweryBy(id: String) {
        repository.getBreweryBy(id: id) { [weak self] result in
            switch result {
                case .success(let breweryResponse):
                    let parsedBrewery = BreweryObject(brewery: breweryResponse)
                    self?.state = .success(brewery: parsedBrewery)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchRatedBreweryBy(id: String) {
        let email = getLastEmail()
        repository.getRatedBreweries(email: email) { [weak self] result in
            guard let self = self  else {return}
            switch result {
                case .success(let breweryResponse):
                if self.isBreweryEvaluated(breweryResponse: breweryResponse, id: id) {
                    self.stateRatedBrewery = .evaluated
                }
                else {
                    self.stateRatedBrewery = .noEvaluated
                }
                case .failure(let error):
                print("ERROR GET RATED BREWERIS \(error)")
            }
        }
    }
    
    //conferir se o id da cervejaria passado como parâmetro foi avaliado pelo email
    func isBreweryEvaluated(breweryResponse: [Brewery], id: String) -> Bool {
        for brewery in breweryResponse {
            if (brewery.id == id) {
                return true
            }
        }
        return false
    }
    
    func checkMapData(brewery: BreweryObject) -> Bool {
        if (brewery.latitute == 0 && brewery.longitude == 0) {
           return false
        }
        return true
    }
    
    public func getLastEmail() -> String {
        var lastEmail = ""
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        do {
            lastEmail = try String(contentsOf: fileURL, encoding: .utf8)
            print("último email salvo \(lastEmail)")
        }
        catch {
            print("Error")
        }
        return lastEmail
    }
}
