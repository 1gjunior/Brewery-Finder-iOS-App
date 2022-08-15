//
//  BreweryAPIService.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 15/08/22.
//

import Foundation

class BreweryAPIService {
    private static let apiBaseURL = "https://bootcamp-mobile-01.eastus.cloudapp.azure.com"
    
    static func getBreweriesURLString(city: String) -> String {
        apiBaseURL + "/breweries?by_city=\(city)"
    }
}
