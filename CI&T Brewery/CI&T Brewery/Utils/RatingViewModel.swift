//
//  RatingViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 19/08/22.
//

import Foundation

enum EmailState {
    case blank
    case invalid
    case valid
}

class RatingViewModel {
    @Published private(set) var emailState: EmailState = .blank
    
    public func saveUserEmailInFileStorage(emailText: String) {
        let fileURL = FileManager.documentsDirectoryURL.appendingPathComponent(FileManager.userEmailTxt)
        do {
            try emailText.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error writing")
        }
    }
    
    public func isEmailValid(emailText: String) {
        if (emailText.isEmpty) {
            emailState = .blank
        } else if emailText.isEmail() {
            emailState = .valid
        } else {
            emailState = .invalid
        }
    }
}
