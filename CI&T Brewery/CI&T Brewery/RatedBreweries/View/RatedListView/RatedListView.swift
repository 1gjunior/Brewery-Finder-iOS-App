//
//  RatedListView.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 14/09/22.
//

import Foundation
import UIKit

public protocol RatedListViewDelegate: AnyObject{
	func didSorted(type: SortType)
}

class RatedListView: UIView{
	private var breweries: [Brewery] = []
    public weak var delegate: RatedListViewDelegate?
	
	private lazy var sortView: SortView = {
		let sortView = SortView()
		sortView.translatesAutoresizingMaskIntoConstraints = false
		sortView.delegate = self
		return sortView
	}()
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		commonInit()
	}
	
	private func commonInit() {
		guard let viewFromXib = Bundle.main.loadNibNamed("RatedListView", owner: self, options: nil)?[0] as? UIView else { return }
		viewFromXib.frame = self.bounds
		addSubview(viewFromXib)
		
		self.lbTableView.delegate = self
		self.lbTableView.dataSource = self
		lbTableView.register(UINib(nibName: "RatedBreweryTableViewCell", bundle: nil), forCellReuseIdentifier: "RatedBreweryTableViewCell")
	}
	
	@IBOutlet var contentView: UIView!
	
	@IBOutlet weak var lbTitle: UILabel!{
		didSet{
			lbTitle.text = NSLocalizedString("ratedViewTitle", comment: "")
			lbTitle.font = UIFont.robotoRegular(ofSize: 18)
			lbTitle.textColor = UIColor.breweryBlack()
		}
	}
	
	@IBOutlet weak var lbResult: UILabel!{
		didSet{
			lbResult.font = UIFont.robotoLight(ofSize: 18)
			lbResult.textColor = UIColor.breweryBlack()
		}
	}
	@IBOutlet weak var lbFilterText: UILabel!{
		didSet{
			lbFilterText.font = UIFont.robotoLight(ofSize: 14)
			lbFilterText.textColor = UIColor.breweryBlack()
		}
	}
	@IBOutlet weak var lbTableView: UITableView!
	
	
	@IBAction func openSortView(_ sender: UIButton) {
		contentView.addSubview(sortView)
		constraintSortView()
	}
    
	private func constraintSortView() {
		 sortView.translatesAutoresizingMaskIntoConstraints = false
		 sortView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
		 sortView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
		 sortView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
		 sortView.heightAnchor.constraint(equalToConstant: 150).isActive = true
	}
    
	public func setRatedResultText(_ text: String) {
		lbResult.text = text
	}
}

extension RatedListView: UITableViewDelegate, UITableViewDataSource {
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
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "RatedBreweryTableViewCell", for: indexPath) as? RatedBreweryTableViewCell else {
			return UITableViewCell()
		}
		
		let item = breweries[indexPath.section]
		cell.configure(for: item)
		
		return cell
	}
	
	public func update(_ breweries: [Brewery]){
        self.breweries = breweries
        self.lbTableView.reloadData()
	}
}


extension RatedListView: SortViewDelegate {
    func removeView() {
        self.willRemoveSubview(sortView)
        sortView.removeFromSuperview()
    }
    
	func didSorted(type: SortType) {
		 delegate?.didSorted(type: type)
		 
		 if type == .sortedName {
			 lbFilterText.text = NSLocalizedString("name", comment: "")
		 } else {
			 lbFilterText.text = NSLocalizedString("rating", comment: "")
		 }
	}
}
