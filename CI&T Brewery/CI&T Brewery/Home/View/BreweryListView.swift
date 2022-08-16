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
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("BreweryListView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
