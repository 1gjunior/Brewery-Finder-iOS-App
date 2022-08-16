//
//  BreweryListView.swift
//
//
//  Created by Gilberto Junior on 15/08/22.
//

import UIKit

class BreweryListView: UIView {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("BreweryListView", owner: self, options: nil)![0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}
