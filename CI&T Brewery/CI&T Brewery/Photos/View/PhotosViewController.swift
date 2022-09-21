//
//  RatingViewController.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 17/08/22.
//

import Combine
import UIKit
import PhotosUI

class PhotosViewController: UIViewController, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var pickerConfiguration = PHPickerConfiguration()
    var picker: PHPickerViewController?
    var images: [UIImage?] = []
    var lastImage: UIImage? = nil
    var id: String
    private var cancellables: Set<AnyCancellable> = []
    var viewModel: PhotosViewModel
    var completion: (() -> ())
    
    @IBAction func dismissPhotosView(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            self?.completion()
            self?.dismiss(animated: true)
        }
    }
    
    init(id: String, completion: @escaping (() -> ())) {
        self.id = id
        self.completion = completion
        viewModel = .init(id: id)
        super.init(nibName: "PhotosViewController", bundle: nil)
        self.view.subviews.first?.layer.cornerRadius = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupPicker()
    }
    
    func setupPicker() {
        pickerConfiguration.selectionLimit = 10
        pickerConfiguration.filter = .images
        picker = PHPickerViewController(configuration: pickerConfiguration)
        picker?.delegate = self
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
       picker.dismiss(animated: true)
        for result in results {
            let provider = result.itemProvider
     
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage, !self.images.contains(image) {
                            self.lastImage = image
                            self.post()
                    }
                }
            }
        }
    }
    
    func post() {
        guard let data = lastImage?.jpegData(compressionQuality: 0.0) else { return }
        
        viewModel.postPhotos(imageData: data) { [weak self] in
            guard let self = self else { return }
            self.dismissPhotosView(self)
        }
    }
    
    @IBAction func galleryTapped(_ sender: Any) {
        present(picker ?? UIViewController(), animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        guard let data = image.jpegData(compressionQuality: 0.0) else { return }
        
        viewModel.postPhotos(imageData: data) { [weak self] in
            guard let self = self else { return }
            self.dismissPhotosView(self)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let viewController = UIImagePickerController()
            viewController.sourceType = .camera
            viewController.allowsEditing = true
            viewController.delegate = self
            present(viewController, animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
}


