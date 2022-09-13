//
//  FavoriteListView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 12/09/22.
//

import Foundation
import UIKit

class FavoriteListView: UIView, UITableViewDelegate, UITableViewDataSource {
    private var breweries: [Brewery] = []
    
    @IBOutlet weak var viewTitle: UILabel! {
        didSet {
            viewTitle.font = UIFont.robotoRegular(ofSize: 18)
            viewTitle.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var resultsCount: UILabel! {
        didSet {
            resultsCount.font = UIFont.robotoLight(ofSize: 18)
            resultsCount.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var filterText: UILabel! {
        didSet {
            filterText.font = UIFont.robotoLight(ofSize: 14)
            filterText.textColor = UIColor.breweryBlack()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("FavoriteListView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "BreweryTableViewCell", bundle: nil), forCellReuseIdentifier: "BreweryTableViewCell")
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        breweries.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryTableViewCell", for: indexPath) as? BreweryTableViewCell else {
            return UITableViewCell()
        }
        
        let item = breweries[indexPath.section]
        cell.configure(cell, for: item)
        
        return cell
    }
    
    public func update(_ breweries: [Brewery]) {
        self.breweries = breweries
        self.tableView.reloadData()
    }
}
