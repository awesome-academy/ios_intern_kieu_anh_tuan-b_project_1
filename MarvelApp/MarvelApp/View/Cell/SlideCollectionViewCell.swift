//
//  SlideViewCellCollectionViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 14/09/2023.
//

import UIKit

final class SlideCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var images: UIImageView!

    var image: UIImage? {
        didSet {
            images.image = image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
