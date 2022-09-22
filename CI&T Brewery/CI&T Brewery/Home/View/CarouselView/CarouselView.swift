//
//  CarouselView.swift
//  CI&T Brewery
//
//  Created by Pedro Henrique Catanduba de Andrade on 19/08/22.
//

import UIKit

class CarouselView: UIView {
    var breweries: [Brewery] = []
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
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let brewery = breweries[indexPath.row]
        delegate?.goToDetailWith(id: brewery.id)
    }
}

extension CarouselView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        breweries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCellView else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 10
        cell.configure(breweries[indexPath.row])
        
        return cell
    }
}

protocol CarouselViewDelegate: AnyObject {
    func goToDetailWith(id: String)
}
