//
//  PhotosViewModel.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 20/09/22.
//

import Foundation

class PhotosViewModel {
    let repository: BreweryRepositoryProtocol
    let id: String
    var statePostPhotos: PostPhotoViewModelState?
    
    init(repository: BreweryRepositoryProtocol = BreweryRepository(), id: String) {
        self.repository = repository
        self.id = id
    }
    
    func postPhotos(imageData: Data, completion: @escaping (() -> ())) {
        repository.postPhotosByBrewery(imageData: imageData, breweryId: id) {[weak self] response in
            switch response {
            case .failure(_):
                print("ERRO BREWERY DETAIL VIEW MODEL")
                self?.statePostPhotos = .error
            case .success(_):
                completion()
                self?.statePostPhotos = .success
            }
        }
    }
}
