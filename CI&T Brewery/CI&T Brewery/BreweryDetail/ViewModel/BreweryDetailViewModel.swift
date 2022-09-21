//
//  BreweryDetailViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation
import Combine
import Resolver

enum BreweryDetailViewModelState {
    case success(brewery: BreweryObject)
}

enum PostPhotoViewModelState {
    case initial
    case success
    case error
}

enum EvaluationState {
    case evaluated
    case noEvaluated
}

class BreweryDetailViewModel {
    var id: String? = nil
    var breweriePhotosSubsject = PassthroughSubject<[BreweryPhotos], Error>()
    let repository: BreweryRepositoryProtocol
    var lastImages: [BreweryPhotos] = []
    var savedImages: [String : [BreweryPhotos]] = [:]
    @Injected var manager: FavoriteBreweriesManagerProtocol
    @Published private(set) var state: BreweryDetailViewModelState?
    @Published private(set) var stateRatedBrewery: EvaluationState?
    
    init(repository: BreweryRepositoryProtocol = BreweryRepository()) {
        self.repository = repository
    }
    
    func fetchBrewery() {
        guard let id = id else { return }
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
    
    //TODO: CRIAR UM USE CASE, RETORNA UMA CERVEJARIA COM A INFO DE AVALIAÇÃOww
    func checkRatingByBrewery() {
        let email = getLastEmail()
        guard let email = email else {return}
        repository.getRatedBreweries(email: email) { [weak self] result in
            guard let self = self  else {return}
            switch result {
            case .success(let breweryResponse):
                if self.isBreweryEvaluated(breweryResponse: breweryResponse) {
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
    
    func handleFavoriteBrewery(brewery: Brewery) {
        if ((manager.getBrewery(with: brewery.id)?.id) != nil) {
            manager.deleteFavoriteBreweries(id: brewery.id)
        } else {
            manager.saveFavoriteBrewery(brewery: brewery)
        }
    }
    
    func getButtonIsFavorited(with id: String) -> Bool {
        var state: FavoriteButtonState = .unselected
        
        if manager.getBrewery(with: id) != nil {
            state = .selected
        } else {
            state = .unselected
        }
        
        return state.isSelected
    }
    
    func isBreweryEvaluated(breweryResponse: [Brewery]) -> Bool {
        guard let id = id else { return false }
        return breweryResponse.contains(where: {$0.id == id })
    }
    
    func isWebsiteAvailable(brewery: BreweryObject) -> Bool {
        brewery.website != nil
    }
    
    func isCoordinationAvailable(brewery: BreweryObject) -> Bool {brewery.latitute != nil && brewery.longitude != nil}
    
    public func getLastEmail() -> String? {
        var lastEmail: String?
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        do {
            lastEmail = try String(contentsOf: fileURL, encoding: .utf8)
            print("lastEmail \(lastEmail ?? "")")
        }
        catch {
            return nil
        }
        return lastEmail
    }
    
    func fetchPhotosByBrewery() {
        guard let id = id else { return }
        repository.getBreweryPhotos(id: id) { [weak self] result in
            switch result {
            case .success(let breweryPhotosResponse):
                self?.breweriePhotosSubsject.send(breweryPhotosResponse)
                print("fetch response \(breweryPhotosResponse)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

