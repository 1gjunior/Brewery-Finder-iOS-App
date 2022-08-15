//
//  BreweryListView.swift
//  
//
//  Created by Gilberto Junior on 15/08/22.
//

import UIKit

class BreweryListView: UIView {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var contentView: UIView!
    public override init(frame: CGRect) {
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
                contentView.frame = self.bounds
                contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
