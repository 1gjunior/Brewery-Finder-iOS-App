//
//  RatingViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 19/08/22.
//

import Foundation

enum FieldsState {
    case blank
    case invalid
    case valid
}

class RatingViewModel {
    @Published private(set) var fieldsState: FieldsState = .blank
    
    public func saveUserEmailInFileStorage(emailText: String) {
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        do {
            try emailText.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
    }
    
    public func fieldsValidation(emailText: String, rating: Double) {
        if !emailText.isEmpty && !emailText.isEmail() {
            fieldsState = .invalid
        } else if emailText.isEmail() && rating > 0 {
            fieldsState = .valid
        } else {
            fieldsState = .blank
        }
    }
}
