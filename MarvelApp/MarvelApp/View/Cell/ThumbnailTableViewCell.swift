//
//  ThumbnailTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 15/09/2023.
//

import UIKit

class ThumbnailTableViewCell: UITableViewCell {

    @IBOutlet private weak var thumbnailCollectionView: UICollectionView!

    // TODO: fix later
    private var numberOfItems = 5

    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailCollectionView.register(
            UINib(nibName: String(describing: ThumbnailCollectionViewCell.self),
                  bundle: nil), forCellWithReuseIdentifier: "thumbnailCollection")
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.dataSource = self
    }

}

extension ThumbnailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = thumbnailCollectionView.dequeueReusableCell(
            withReuseIdentifier: "thumbnailCollection", for: indexPath) as? ThumbnailCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ThumbnailTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height - 12)
    }
}
