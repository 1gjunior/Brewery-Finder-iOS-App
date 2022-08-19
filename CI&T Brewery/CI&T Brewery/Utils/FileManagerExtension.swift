//
//  FileManagerExtension.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 18/08/22.
//

import Foundation

public extension FileManager {
    static let userEmailTxt = "userEmail.txt"
    
    static var documentsDirectoryURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
