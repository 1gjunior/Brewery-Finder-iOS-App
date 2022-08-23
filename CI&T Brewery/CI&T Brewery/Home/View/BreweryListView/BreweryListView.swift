//
//  BreweryListView.swift
//
//
//  Created by Gilberto Junior on 15/08/22.
//

import UIKit

class BreweryListView: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet var contentView: UIView!
    @IBOutlet private var resultsLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var sortLabel: UILabel!
    private var breweries: [Brewery] = []
    private var action: ((_ id: String) -> ())? 
    
    @IBAction func goToSortView(_ sender: UIButton) {
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("BreweryListView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "BreweryListTableViewCell", bundle: nil), forCellReuseIdentifier: "BreweryListCell")
    }
    
    public func setSearchResultText(_ text: String) {
        resultsLabel.text = text
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryListCell", for: indexPath) as? BreweryListTableViewCell else { return UITableViewCell() }
        
        let brewery = breweries[indexPath.section]
        cell.configure(cell, for: brewery)
        
        return cell
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        breweries.count
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = breweries[indexPath.section].id
       
        guard let action = action else { return }
        action(id)
    }
    
    public func update(_ breweries: [Brewery], actionForCell: @escaping (_ id: String) -> ()) {
        self.breweries = breweries
        self.tableView.reloadData()
        self.action = actionForCell
    }
}


