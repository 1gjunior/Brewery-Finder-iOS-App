//
//  FavoriteListView.swift
//  CI&T Brewery
//
//  Created by Rafaela Cristina Souza dos Santos on 12/09/22.
//

import Foundation
import UIKit
import Resolver

public protocol FavoriteListViewDelegate: AnyObject{
    func didSorted(type: SortType)
    func goToDetailWith(id: String)
    func didDeleted()
}

class FavoriteListView: UIView {
	
    @Injected private var favoriteManager: FavoriteBreweriesManagerProtocol
    private var breweries: [FavoriteBreweries] = []
    weak var delegate: FavoriteListViewDelegate?
    private var action: ((_ id: String) -> ())?
    private let resultsTitle = NSLocalizedString("resultsText", comment: "")
    private let resultTitle = NSLocalizedString("resultText", comment: "")
    
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
        guard let viewFromXib = Bundle.main.loadNibNamed("FavoriteListView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "BreweryTableViewCell", bundle: nil), forCellReuseIdentifier: "BreweryTableViewCell")
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewTitle: UILabel! {
        didSet {
            viewTitle.text = NSLocalizedString("favoriteViewTitle", comment: "")
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
        
    @IBAction func openSortView(_ sender: Any) {
        contentView.addSubview(sortView)
        constrainSortView()
    }
    
    private func constrainSortView() {
        sortView.translatesAutoresizingMaskIntoConstraints = false
        sortView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        sortView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        sortView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        sortView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    public func setSearchResultFavoriteText(_ text: String) {
        resultsCount.text = text
    }
}

extension FavoriteListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("favorites count \(breweries.count)")
        return breweries.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryTableViewCell", for: indexPath) as? BreweryTableViewCell else {
            return UITableViewCell()
        }
        
        let item = breweries[indexPath.section]
        cell.configure(for: item)
		
		 cell.delegate = self
		 cell.brewery = breweries[indexPath.section]
		 
		 return cell
    }

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = breweries[indexPath.section].id else {return}
        guard let action = action else { return }
        action(id)
    }
    
    public func setActions(onSelect: @escaping ((String) -> ())) -> () {
        self.action = onSelect
    }
    
    public func update(_ breweries: [FavoriteBreweries]) {
        self.breweries = breweries
        self.tableView.reloadData()
    }
}

extension FavoriteListView: SortViewDelegate {
    func removeView() {
        self.willRemoveSubview(sortView)
        sortView.removeFromSuperview()
    }
    
    func didSorted(type: SortType) {
        delegate?.didSorted(type: type)
        
        if type == .sortedName {
            filterText.text = NSLocalizedString("name", comment: "")
        } else {
            filterText.text = NSLocalizedString("rating", comment: "")
        }
    }
}

extension FavoriteListView: FavoriteCellActionDelegate {
    func didFavoriteButtonTapped(brewery: FavoriteBreweries) {
        let deleteFavoriteView = DeleteFavoriteView(favoriteBrewery: brewery)
        self.parentViewController?.modalPresentationStyle = .overFullScreen
        self.parentViewController?.modalTransitionStyle = .flipHorizontal
        deleteFavoriteView.dismissActionDelete = delegate?.didDeleted
        self.parentViewController?.present(deleteFavoriteView, animated: true, completion: nil)
    }
}

extension FavoriteListView {
	 var parentViewController: UIViewController? {
		  var parentResponder: UIResponder? = self.next
		  while parentResponder != nil {
				if let viewController = parentResponder as? UIViewController {
					 return viewController
				}
				parentResponder = parentResponder?.next
		  }
		  return nil
	 }
}
