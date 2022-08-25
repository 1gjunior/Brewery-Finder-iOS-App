//
//  Brewery.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 15/08/22.
//

import Foundation

struct Brewery: Codable, Hashable {
    let id: String
    let name: String
    let type: String
    let street: String?
    let address2: String?
    let address3: String?
    let city: String
    let state: String
    let postalCode: String
    let country: String
    let longitude: Double?
    let latitude: Double?
    let website: String?
    let phone: String?
    let average: Double
    let sizeEvaluations: Double
    let photos: [String?]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type = "brewery_type"
        case street
        case address2
        case address3
        case city
        case state
        case postalCode = "postal_code"
        case country
        case longitude
        case latitude
        case website = "website_url"
        case phone
        case average
        case sizeEvaluations = "size_evaluations"
        case photos
    }
}

struct BreweryEvaluation: Codable {
    let email: String
    let breweryId: String
    let evaluationGrade: Double
    
    enum CodingKeys: String, CodingKey {
        
        case email = "email"
        case breweryId = "brewery_id"
        case evaluationGrade = "evaluation_grade"
    }
}

struct ApiEvaluationResponse: Codable {
    let email: String
    let breweryId: String
    let evaluationGrade: Double
}
