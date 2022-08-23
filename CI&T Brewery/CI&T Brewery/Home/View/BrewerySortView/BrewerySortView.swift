//
//  BrewerySortView.swift
//  CI&T Brewery
//
//  Created by Ramon Queiroz dos Santos on 23/08/22.
//

import Foundation
import UIKit

public class SortView: UIView{
    
    viewDidLoad(){
        
        let checkbox = CircularCheckbox(frame: CGRect(x: 70, y: 200, width: 70, height: 70))
        let label = UILabel(frame: CGRect(x: 150, y: 200, width: 200, height: 70))
        label.text = "aqui"
        view.addSubview(label)
        view?.addSubview(checkbox)
    }
    
}

final class CircularCheckbox: UIView {
    override init(frame: CGRect){
        super.init(frame:frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = frame.size.width / 2.0
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChecked(_ isChecked: Bool){
        if isChecked{
            backgroundColor = .systemGreen
        }
        else {
            backgroundColor = .systemBackground
        }
    }
}


