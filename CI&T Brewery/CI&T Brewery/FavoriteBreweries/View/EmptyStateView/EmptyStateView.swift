//
//  EmptyStateView.swift
//  CI&T Brewery
//
//  Created by Gilberto Junior on 12/09/22.
//

import UIKit

class EmptyStateView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    public func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = bounds
        addSubview(viewFromXib)
    }
}
