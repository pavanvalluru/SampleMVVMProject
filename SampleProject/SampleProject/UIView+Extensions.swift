//
//  UIButton+Extensions.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 03.06.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func drawBottomBorderWithLayer(borderLayer: CALayer, color: UIColor, borderHeight: CGFloat) {
        
        borderLayer.backgroundColor = color.cgColor
        borderLayer.frame = CGRect(x: self.frame.origin.x, y: self.frame.height - borderHeight, width: self.frame.size.width, height: borderHeight)
        self.superview?.layer.addSublayer(borderLayer)
    }
    
    func applyGradient(startColor: UIColor = UIColor(red: 51, green: 102, blue: 204), endColor: UIColor = AppConstants.Colors.MYAPP_BLUE_COLOR)
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
