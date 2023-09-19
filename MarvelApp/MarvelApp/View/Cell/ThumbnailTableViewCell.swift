//
//  ThumbnailTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 15/09/2023.
//

import UIKit

final class ThumbnailTableViewCell: UITableViewCell {

    @IBOutlet private weak var thumbnailCollectionView: UICollectionView!

    private var thumbnails = [OverviewInformation]()

    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailCollectionView.register(
            UINib(nibName: String(describing: ThumbnailCollectionViewCell.self),
                  bundle: nil), forCellWithReuseIdentifier: "thumbnailCollection")
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.dataSource = self
    }

    public func configure(_ passingValues: [OverviewInformation]) {
        self.thumbnails = passingValues
        DispatchQueue.main.async { [weak self] in
            self?.thumbnailCollectionView.reloadData()
        }
    }
}

extension ThumbnailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnails.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = thumbnailCollectionView.dequeueReusableCell(
            withReuseIdentifier: "thumbnailCollection", for: indexPath) as? ThumbnailCollectionViewCell {

            let thumbnail = thumbnails[indexPath.row].thumbnail

            guard let url = URL(string: thumbnail.path + "." + thumbnail.extension) else {
                return UICollectionViewCell()
            }
            ImageProvider.shared.fetchData(url: url) { image in
                DispatchQueue.main.async {
                    cell.image = image
                }
            }
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
