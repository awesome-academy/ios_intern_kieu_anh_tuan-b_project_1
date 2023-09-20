//
//  ThumbnailCollectionViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 15/09/2023.
//

import UIKit

final class ThumbnailCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var thumbnailImageView: UIImageView!

    var image: UIImage? {
        didSet {
            thumbnailImageView.image = image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
