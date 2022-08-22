//
//  CarouselView.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 19/08/22.
//

import UIKit

class CarouselView: UIView, UICollectionViewDelegate {
    var dataSource: UICollectionViewDiffableDataSource<Section, Brewery>?
    var action: ((String) -> ())? = nil
    
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
    }
    
    enum Section {
        case main
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCellView else { return }
        guard let id = cell.brewery?.id else { return }
        guard let action = action else { return }

        action(id)
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let groupWidth = CGFloat(140 * (dataSource?.snapshot().numberOfItems ?? 0))
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(234))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(234))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    public func configureDataSource(_ breweries: [Brewery], action: @escaping (String) -> ()) {
        dataSource = UICollectionViewDiffableDataSource<Section, Brewery>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, brewery in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCellView else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = 10
            cell.configure(brewery)
            
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Brewery>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(breweries)
        
        
        dataSource?.apply(initialSnapshot)
        collectionView.collectionViewLayout = configureLayout()
        self.action = action
    }
}
