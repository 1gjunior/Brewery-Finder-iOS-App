//
//  EmptyStates.swift
//  CI&T Brewery
//
//  Created by Pamella Victoria Soares Lima on 15/08/22.
//

import UIKit

public class ErrorStateView: UIView {
    
    @IBOutlet weak var titleEmptyStateLabel: UILabel!
    @IBOutlet weak var subtitleEmptyStateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("ErrorStateView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        backgroundColor = .red
    }
    
    public func changeText(_ error: EmptyError) {
        self.titleEmptyStateLabel.text = error.text
    }
}

public enum EmptyError: String {
    case search
    case result
    
    var text: String {
        switch self{
        case .search: return NSLocalizedString("inputEmptyStateText" , comment: "")
        case .result: return NSLocalizedString("resultEmptyStateText", comment: "")
        }
    }
}
