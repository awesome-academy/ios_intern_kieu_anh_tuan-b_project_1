//
//  ComicTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 17/09/2023.
//

import UIKit

final class ComicTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var comicImageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var goDetail: (() -> Void)?
    var addToFavorite: (() -> Void)?

    public func configure(comic: Comic) {
        titleLabel.text = comic.title

        if let price = comic.prices?.first?.price {
            priceLabel.text = "$" + String(price)
        } else {
            priceLabel.text = "Unknown"
        }

        if let thumbnail = comic.thumbnail {
            guard let url = URL(string: thumbnail.path + "." + thumbnail.extension) else {
                return
            }
            ImageProvider.shared.fetchData(url: url) { image in
                DispatchQueue.main.async { [weak self] in
                    self?.comicImageView.image = image
                }
            }
        }
    }

    public func configureFavorite(isFavorite: Bool) {
        favoriteButton.tintColor = isFavorite ? .red : .white
    }

    @IBAction func previewButtonTapped(_ sender: Any) {
        goDetail?()
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        addToFavorite?()
    }
}
