//
//  ComicPreviewTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 22/09/2023.
//

import UIKit

class ComicPreviewTableViewCell: UITableViewCell {

    @IBOutlet private weak var comicImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(thumbnail: Thumbnail?) {
        if let thumbnail = thumbnail {
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
}
