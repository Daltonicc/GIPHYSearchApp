//
//  UIView+Extension.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

extension UIView {
    func setGradient(gradient: CAGradientLayer, startColor: UIColor, finishColor: UIColor, start: CGPoint, end: CGPoint) {
        gradient.colors = [startColor.cgColor, finishColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = start
        gradient.endPoint = end
        layer.addSublayer(gradient)
    }
}
