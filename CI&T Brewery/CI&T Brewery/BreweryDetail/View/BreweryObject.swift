//
//  BreweryDetailObject.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 16/08/22.
//

import Foundation

class BreweryObject {
    var brewery: Brewery
    
    var id: String
    var name: String
    var type: String
    var address: String
    var latitute: Double?
    var longitude: Double?
    var website: String?
    var average: Double
    var evaluation: String
    var logo: String
    
    init(brewery: Brewery) {
        self.brewery = brewery
        
        self.id = brewery.id
        self.name = brewery.name
        self.type = brewery.type
        self.latitute = brewery.latitude
        self.longitude = brewery.longitude
        self.website = brewery.website
        self.average = brewery.average
        
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
            
            formattedAddress += (formattedAddress != "" ? ", " : "") + validItem
        }
        
        self.address = formattedAddress
        
        var evaluationString = String(format: "%.f", brewery.sizeEvaluations)
        if brewery.sizeEvaluations > 1 ||
            brewery.sizeEvaluations == 0 {
            evaluationString += " " + NSLocalizedString("evaluations", comment: "")
        } else {
            evaluationString += " " + NSLocalizedString("evaluation", comment: "")
        }
        
        self.evaluation = evaluationString
        
        self.logo = String(name[name.startIndex])
    }
}

extension BreweryObject: Equatable {
    static func == (lhs: BreweryObject, rhs: BreweryObject) -> Bool {
        return lhs.id == rhs.id
    }
}
