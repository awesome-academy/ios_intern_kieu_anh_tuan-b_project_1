//
//  LayerExtension.swift
//  MarvelApp
//
//  Created by Tobi on 21/09/2023.
//

import UIKit

extension CALayer {
    func addBorder(
        edge: UIRectEdge,
        color: UIColor,
        thickness: CGFloat,
        horizontalPadding: CGFloat = 0,
        verticalPadding: CGFloat = 0) {

        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(
                x: horizontalPadding,
                y: 0,
                width: self.frame.width - horizontalPadding * 2,
                height: thickness
            )
        case UIRectEdge.bottom:
            border.frame = CGRect(
                x: horizontalPadding,
                y: self.frame.height - thickness,
                width: self.frame.width - horizontalPadding * 2,
                height: thickness
            )
        case UIRectEdge.left:
            border.frame = CGRect(
                x: 0,
                y: verticalPadding,
                width: thickness,
                height: self.frame.height - verticalPadding * 2
            )
        case UIRectEdge.right:
            border.frame = CGRect(
                x: self.frame.width - thickness,
                y: verticalPadding,
                width: thickness,
                height: self.frame.height - verticalPadding * 2
            )
        default:
            break
        }
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
}
