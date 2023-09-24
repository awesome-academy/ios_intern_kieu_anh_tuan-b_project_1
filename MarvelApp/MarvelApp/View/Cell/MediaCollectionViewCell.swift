//
//  MediaCollectionViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 22/09/2023.
//

import UIKit

final class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var mediaImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        mediaImageView.applyCircle()
    }

    public func configure(image: UIImage?) {
        mediaImageView.image = image
    }
}
