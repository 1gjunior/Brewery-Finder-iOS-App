//
//  BreweryDetailViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation
import Combine

enum BreweryDetailViewModelState: Equatable {
    case success(brewery: BreweryObject)
    case error
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
    var breweriePhotosSubsject = PassthroughSubject<[BreweryPhotos], Error>()
    let repository: BreweryRepositoryProtocol
    var lastImages: [BreweryPhotos] = []
    var savedImages: [String : [BreweryPhotos]] = [:]
    @Published private(set) var state: BreweryDetailViewModelState?
    @Published private(set) var stateRatedBrewery: EvaluationState?
    @Published private(set) var statePostPhotos: PostPhotoViewModelState?

    init(repository: BreweryRepositoryProtocol = BreweryRepository()) {
        self.repository = repository
    }

    func fetchBreweryBy(id: String) {
        repository.getBreweryBy(id: id) { [weak self] result in
            switch result {
                case .success(let breweryResponse):
                    let parsedBrewery = BreweryObject(brewery: breweryResponse)
                    self?.state = .success(brewery: parsedBrewery)
            case .failure:
                self?.state = .error
            }
        }
    }
    
    func checkRatingByBrewery(id: String) {
        let email = getLastEmail()
        guard let email = email else {return}
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
    
    func isBreweryEvaluated(breweryResponse: [Brewery], id: String) -> Bool {
        breweryResponse.contains(where: {$0.id == id })
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
	
	func fetchPhotosByBrewery(id: String) {
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
    
    func postPhotos(imageData: Data, id: String){
        repository.postPhotosByBrewery(imageData: imageData, breweryId: id) {[weak self] response in
            switch response {
            case .failure(_):
                print("ERRO BREWERY DETAIL VIEW MODEL")
                self?.statePostPhotos = .error
            case .success(_):
                self?.fetchPhotosByBrewery(id: id)
                print("foi")
                self?.statePostPhotos = .success
            }
        }
    }
}

