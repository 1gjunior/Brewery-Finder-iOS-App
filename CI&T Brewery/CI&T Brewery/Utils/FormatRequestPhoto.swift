//
//  FormatRequestPhoto.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 16/09/22.
//
import Foundation
protocol FormatRequestPhotoProtocol {
    static func createBodyWithParameters(filePathKey: String?, imageDataKey: Data, boundary: String) -> Data
    static func generateBoundaryString() -> String
}
class FormatRequestPhoto {
    
    static func createBodyWithParameters(filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        var body = Data()
        
        let filename = UUID().uuidString + ".jpg"
        let mimetype = "image/jpg"
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    static func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}
extension Data {
    mutating func append(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        append(data)
    }
}
