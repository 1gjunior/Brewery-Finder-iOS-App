//
//  RatingViewModelTest.swift
//  CI&T BreweryTests
//
//  Created by Pamella Victoria Soares Lima on 19/09/22.
//
import XCTest
@testable import CI_T_Brewery

class RatingViewModelTest: XCTestCase {
    
    var viewModel: RatingViewModel!
    var repository: BreweryRepositoryMock!
    override func setUp() {
        repository = .init()
        viewModel = RatingViewModel(repository: repository)
    }
    
    func testPostSuccessRatingBreweries() {
      
        XCTAssert(viewModel.stateRating == .initial)
        
        var evaluation = BreweryEvaluation(email: "Pam00@gmail.com", breweryId: "goat-ridge-brewing-new-london", evaluationGrade: 4.5)
        
        viewModel.post(evaluation: evaluation)
        XCTAssert(viewModel.stateRating == .sucess)
    }
    
    func testPostErrorRatingBreweries() {
        repository.networkError = .responseError
        
        var evaluation = BreweryEvaluation(email: "", breweryId: "goat-ridge-brewing-new-london", evaluationGrade: 4.5)
        
        viewModel.post(evaluation: evaluation)
        XCTAssert(viewModel.stateRating == .error)
    }
    
    func testSaveUserEmailInFileStorage() {
        let email = "teste@gmail.com"
        viewModel.saveUserEmailInFileStorage(emailText: email)
        var lastEmail: String = ""
        
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        do {
            lastEmail = try String(contentsOf: fileURL, encoding: .utf8)
            print("lastEmail \(lastEmail )")
        }
        catch {
           print("")
        }
        
        XCTAssertEqual(email, lastEmail)
    }
    
    func testFieldsValidationInvalid() {
        let rating = 4.6
        var email = "@gmail"
        
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .invalid)
        
        email = ".com"
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .invalid)
        
        email = "aklfjsklj"
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .invalid)
        
        email = "teste@gmail"
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .invalid)
        
        email = "teste@gmail."
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .invalid)
    }
    
    func testFieldsValidationValid() {
        
        let rating = 4.6
        let email = "teste@gmail.com"
        
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .valid)
    }
    
    func testFieldsValidationBlank() {
        
        var rating = 4.6
        var email = ""
        
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .blank)
        
        rating = 0
        email = "test@gmail.com"
        
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .blank)
        
        rating = 0
        email = ""
        
        viewModel.fieldsValidation(emailText: email, rating: rating)
        XCTAssert(viewModel.fieldsState == .blank)
    }
}


