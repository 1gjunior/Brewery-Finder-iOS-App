//
//  RatingViewModel.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 19/08/22.
//

import Foundation

class RatingViewModel {
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
