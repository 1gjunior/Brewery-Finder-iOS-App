//
//  BreweryDetailViewModelTest.swift
//  CI&T BreweryTests
//
//  Created by Ramon Queiroz dos Santos on 21/09/22.
//

import XCTest
@testable import CI_T_Brewery

class PhotosViewModelTest: XCTestCase {
	
	var viewModel: PhotosViewModel!
	var repository: BreweryRepositoryMock!
	let id: String = ""
	
	override func setUp() {
		repository = .init()
		viewModel = PhotosViewModel(repository: repository, id: id)
	}
	
	func testPostPhotosSuccess() {
		let image = UIImage(named: "star_border")
		guard let data = image?.jpegData(compressionQuality: 0.0) else { return }
		viewModel.postPhotos(imageData: data, completion: { })
		XCTAssert(viewModel.statePostPhotos == .success)
	}
	
	func testPostPhotosError() {
		repository.networkError = .responseError
		let image = UIImage(named: "star_border")
		guard let data = image?.jpegData(compressionQuality: 0.0) else { return }
		viewModel.postPhotos(imageData: data, completion: { })
		XCTAssert(viewModel.statePostPhotos == .error)
	}
	
}
