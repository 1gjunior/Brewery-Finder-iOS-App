//
//  SucessStateView.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 17/08/22.
//

import Foundation
import UIKit

public class SucessStateView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("SucessStateView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}
