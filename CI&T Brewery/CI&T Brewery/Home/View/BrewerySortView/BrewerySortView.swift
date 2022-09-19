//
//  BrewerySortView.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 23/08/22.
//

import Foundation
import UIKit

public enum SortType: Int {
    case sortedName
    case sortedRating
    
    var labelText: String {
        switch self {
        case .sortedName: return NSLocalizedString("Nome (A a Z)", comment: "")
        case .sortedRating: return NSLocalizedString("Nota (menor para maior)", comment: "")
        }
    }
}

public protocol SortViewDelegate: AnyObject {
    func didSorted(type: SortType)
    func removeView()
}

public class SortView: UIView, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    public weak var delegate: SortViewDelegate?
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont.robotoRegular(ofSize: 16)
            titleLabel.textColor = UIColor.breweryBlack()
            titleLabel.text = NSLocalizedString("Ordenar por", comment: "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("BrewerySortView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(UINib(nibName: "SortCell", bundle: nil), forCellReuseIdentifier: "SortCell")
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath) as? SortCell else { return UITableViewCell() }
        
        cell.sortButton.setImage(UIImage(named: "RadioDisabled"), for: .normal)
        cell.sortButton.setImage(UIImage(named: "RadioSelected"), for: .selected)

        if indexPath.row == SortType.sortedName.rawValue {
            cell.type = .sortedName
        } else {
            cell.type = .sortedRating
        }
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SortCell else { return }
        cell.sortButton.isSelected = true
        
        let index: IndexPath
        if cell.type == .sortedName {
            delegate?.didSorted(type: .sortedName)
            index = IndexPath(row: SortType.sortedRating.rawValue, section: indexPath.section)
        } else {
            delegate?.didSorted(type: .sortedRating)
            index = IndexPath(row: SortType.sortedName.rawValue, section: indexPath.section)
        }
        
        tableView.deselectRow(at: index, animated: true)
        delegate?.removeView()
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SortCell else { return }
        cell.sortButton.isSelected = false
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
}


