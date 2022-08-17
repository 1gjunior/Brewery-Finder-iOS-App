//
//  BreweryDetailObject.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation

class BreweryObject {
    private var brewery: Brewery
    
    var name: String
    var type: String
    var address: String
    var latitute: Double
    var longitude: Double
    var website: String
    var average: Double
    var evaluation: Double
    
    init(brewery: Brewery) {
        self.brewery = brewery
        
        self.name = brewery.name
        self.type = brewery.type
        self.latitute = brewery.latitude ?? 0
        self.longitude = brewery.longitude ?? 0
        self.website = brewery.website ?? ""
        self.average = brewery.average
        self.evaluation = brewery.sizeEvaluations        
        
        let arrayAddress = [
            brewery.street,
            brewery.city,
            brewery.state,
            brewery.postalCode,
            brewery.country
        ]
        
        var formattedAddress = ""
        for item in arrayAddress {
            guard let validItem = item else {
                continue
            }
            
            formattedAddress += ", " + validItem
        }
        
        self.address = formattedAddress
    }
}
