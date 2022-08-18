//
//  Extensions.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 18/08/22.
//

import Foundation
import UIKit

//REGEX AND EXTENSIONS TO VALID AN EMAIL

private let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
private let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
private let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

extension String {
    func isEmail() -> Bool {
        return emailPredicate.evaluate(with: self)
    }
}

extension UITextField {
    func isEmail() -> Bool {
        return self.text?.isEmail() ?? false
    }
}
