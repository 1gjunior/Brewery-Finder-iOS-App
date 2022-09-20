//
//  BreweryMock.swift
//  CI&T BreweryTests
//
//  Created by Rafaela Cristina Souza dos Santos on 19/09/22.
//

import Foundation
@testable import CI_T_Brewery

class BreweryMock {
    static let breweries = [
        Brewery(id: "aaaaa", name: "aaaaa", type: "test", street: "test",
                address2: "test", address3: "test", city: "test", state: "test",
                postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
                website: "test", phone: "test", average: 1.0, sizeEvaluations: 0.0, photos: nil),
        Brewery(id: "ckasmplp", name: "ckasmplp", type: "test", street: "test",
                address2: "test", address3: "test", city: "test", state: "test",
                postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
                website: "test", phone: "test", average: 0.0, sizeEvaluations: 0.0, photos: nil),
        Brewery(id: "fopsdk", name: "fopsdk", type: "test", street: "test",
                address2: "test", address3: "test", city: "test", state: "test",
                postalCode: "test", country: "test", longitude: 0.0, latitude: 0.0,
                website: "test", phone: "test", average: 1.0, sizeEvaluations: 0.0, photos: nil)
    ]
    
    static let breweryObject = BreweryObject(brewery: breweries[0])
}
