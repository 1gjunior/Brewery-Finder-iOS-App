//
//  StringExtension.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 17/08/22.
//

import Foundation
import UIKit

extension String {
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}
