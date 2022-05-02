//
//  UIView+Extension.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

extension UIView {
    func setGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0).cgColor,
            UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3).cgColor
        ]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
