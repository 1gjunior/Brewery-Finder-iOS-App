//
//  FavoriteView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 12/09/22.
//

import Foundation
import UIKit

class FavoriteView: UIView {
    var breweries: [Brewery] = [
        Brewery(
            id: "alphabet-city-brewing-co-new-york",
            name: "Alphabet City Brewing Co",
            type: "contract",
            street: "96 Avenue C Frnt 4",
            address2: nil,
            address3: nil,
            city: "New York",
            state: "New York",
            postalCode: "10009-7055",
            country: "United States",
            longitude: nil,
            latitude: nil,
            website: nil,
            phone: nil,
            average: 4.2,
            sizeEvaluations: 141,
            photos: nil
        ),
        Brewery(
            id: "alphabet-city-brewing-co-new-york",
            name: "Alphabet City Brewing Co",
            type: "contract",
            street: "96 Avenue C Frnt 4",
            address2: nil,
            address3: nil,
            city: "New York",
            state: "New York",
            postalCode: "10009-7055",
            country: "United States",
            longitude: nil,
            latitude: nil,
            website: nil,
            phone: nil,
            average: 4.2,
            sizeEvaluations: 141,
            photos: nil
        )
    ]
    
    @IBOutlet weak var viewTitle: UILabel! {
        didSet {
            viewTitle.font = UIFont.robotoRegular(ofSize: 18)
            viewTitle.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var resultsCount: UILabel! {
        didSet {
            resultsCount.font = UIFont.robotoLight(ofSize: 18)
            resultsCount.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var filterText: UILabel! {
        didSet {
            filterText.font = UIFont.robotoLight(ofSize: 14)
            filterText.textColor = UIColor.breweryBlack()
        }
    }
}

extension FavoriteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryTableViewCell", for: indexPath) as? BreweryTableViewCell else {
            return UITableViewCell()
        }
        
        let item = breweries[indexPath.row]
        cell.configure(cell, for: item)
                
        return cell
    }
}
