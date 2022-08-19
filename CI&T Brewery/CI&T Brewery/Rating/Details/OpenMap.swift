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
    
    private static let urlGoogleMaps = "https://www.google.com/maps/search/?api=1&query="
    private static let alertTitle = NSLocalizedString("Open Location", comment: "")
    private static let alertMessage = NSLocalizedString("Choose an app to open direction", comment: "")
    private static let actionTitle = NSLocalizedString("Google Maps", comment: "")
    private static let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
    
    static func present(in viewController: UIViewController, sourceView: UIView, latitude: Double, longitude: Double) {
        let actionSheet = UIAlertController(title: alertTitle , message: alertMessage, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            let url = URL(string: urlGoogleMaps + "\(latitude),\(longitude)")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
