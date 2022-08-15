//
//  BreweryAPIService.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 15/08/22.
//

import Foundation

class BreweryAPIService {
    private static let apiBaseURL = "https://bootcamp-mobile-01.eastus.cloudapp.azure.com"
    
    static func getBreweriesURLString(city: String) -> URL? {
        let query = URLQueryItem(name: "by_city", value: city)
        var urlComponents = URLComponents(string: apiBaseURL + "/breweries")
        urlComponents?.queryItems = [query]
        
        return urlComponents?.url
    }
}
