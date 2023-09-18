//
//  ButtonExtension.swift
//  MarvelApp
//
//  Created by Tobi on 18/09/2023.
//

import UIKit

extension UIButton {
    func applyBorderOutline() {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }

    func setSelected() {
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
    }

    func setDeselected() {
        self.backgroundColor = .clear
        self.setTitleColor(.white, for: .normal)
    }
}
