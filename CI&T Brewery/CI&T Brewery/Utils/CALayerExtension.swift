//
//  CALayerExtension.swift
//  CIandTMovieDatabase
//
//  Created by Rafaela Cristina Souza dos Santos on 22/07/22.
//

import UIKit

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
            
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.size.width, height:thickness)

        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: frame.size.height)
            
        case UIRectEdge.right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.size.height)
            
        default: do {}
        }
        
        border.backgroundColor = color.cgColor
        addSublayer(border)
    }
}
