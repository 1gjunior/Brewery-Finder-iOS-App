//
//  CarouselView.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 19/08/22.
//

import UIKit

class CarouselView: UIView, UICollectionViewDelegate {
    var dataSource: UICollectionViewDiffableDataSource<Section, Brewery>?
    var breweries: [Brewery]? = nil {
        didSet {
            configureDataSource()
        }
    }
    weak var delegate: CarouselViewDelegate? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        self.collectionView.register(UINib(nibName: "CarouselCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        collectionView.delegate = self
    }
    
    enum Section {
        case main
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let brewery = breweries?[indexPath.row] else { return }
        delegate?.goToDetailWith(id: brewery.id)
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let groupWidth = CGFloat(140 * (breweries?.count ?? 0))
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(234))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(234))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.bounces = false
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    public func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Brewery>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, brewery in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCellView else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = 10
            cell.configure(brewery)
            
            return cell
        })
        
        guard let breweries = breweries else {
            return
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Brewery>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(breweries)
        
        
        dataSource?.apply(initialSnapshot)
        collectionView.collectionViewLayout = configureLayout()
    }
}

protocol CarouselViewDelegate: AnyObject {
    func goToDetailWith(id: String)
}
