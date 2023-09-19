//
//  SlideViewCellCollectionViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 14/09/2023.
//

import UIKit

final class SlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var images: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        images.addGradient(
            colors: [UIColor.black, UIColor.clear],
            startPoint: CGPoint(x: 0.2, y: 1.0),
            endPoint: CGPoint(x: 0.2, y: 0.0))
    }

    public func configure(label: String?, image: UIImage?) {
        images.image = image
        titleLabel.text = label
    }
}
