//
//  OpenMap.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 17/08/22.
//

import CoreLocation
import MapKit
import UIKit

protocol OpenMapDirectionsProtocol {
  static func present(in viewController: UIViewController, sourceView: UIView, latitude: Double, longitude: Double)
}

class OpenMapDirections: OpenMapDirectionsProtocol{
        
    static func present(in viewController: UIViewController, sourceView: UIView, latitude: Double, longitude: Double) {
        let actionSheet = UIAlertController(title: "Open Location", message: "Choose an app to open direction", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { _ in
            let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(latitude),\(longitude)")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
