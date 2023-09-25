//
//  ViewExtension.swift
//  MarvelApp
//
//  Created by Tobi on 19/09/2023.
//

import UIKit

extension UIView {
    func addGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func applyCircle() {
        layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
