//
//  SearchBarExtension.swift
//  MarvelApp
//
//  Created by Tobi on 18/09/2023.
//

import UIKit

extension UISearchBar {
    func customizeView() {
        self.backgroundColor = UIColor.clear
        self.backgroundImage = UIImage()
        self.searchTextField.backgroundColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        self.updateHeight(height: 100)
    }

    func updateHeight(height: CGFloat, radius: CGFloat = 8.0) {
        let image: UIImage? = UIImage.imageWithColor(color: UIColor.clear, size: CGSize(width: 1, height: height))
        setSearchFieldBackgroundImage(image, for: .normal)
        for subview in self.subviews {
            for subSubViews in subview.subviews {
                if #available(iOS 13.0, *) {
                    for child in subSubViews.subviews {
                        if let textField = child as? UISearchTextField {
                            textField.layer.cornerRadius = radius
                            textField.clipsToBounds = true
                        }
                    }
                    continue
                }
                if let textField = subSubViews as? UITextField {
                    textField.layer.cornerRadius = radius
                    textField.clipsToBounds = true
                }
            }
        }
    }
}
