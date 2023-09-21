//
//  InformationImageTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 21/09/2023.
//

import UIKit

final class InformationImageTableViewCell: UITableViewCell {

    @IBOutlet private weak var informationImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        informationImageView.addGradient(
            colors: [UIColor.black, UIColor.clear, UIColor.black],
            startPoint: CGPoint(x: 0.2, y: 1.0),
            endPoint: CGPoint(x: 0.2, y: 0))
    }
}
