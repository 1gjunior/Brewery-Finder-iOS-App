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
    private static let alertTitle = NSLocalizedString("alertTitle", comment: "")
    private static let alertMessage = NSLocalizedString("alertMessage", comment: "")
    private static let actionTitle = NSLocalizedString("actionTitle", comment: "")
    private static let cancelButtonTitle = NSLocalizedString("cancelButtonTitle", comment: "")
    
    static func present(in viewController: UIViewController, sourceView: UIView, latitude: Double, longitude: Double) {
        let actionSheet = UIAlertController(title: alertTitle , message: alertMessage, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            let url = URL(string: urlGoogleMaps + "\(latitude),\(longitude)")
            guard let url = url else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
