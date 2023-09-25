//
//  MediaDetailTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 22/09/2023.
//

import UIKit

protocol MediaTableViewCellDelegate: AnyObject {
    func mediaTableViewCellDidTapCell(_ cell: MediaDetailTableViewCell, information: OverviewInformation)
}

final class MediaDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var mediaCollectionView: UICollectionView!

    private var medias = [OverviewInformation]()
    weak var delegate: MediaTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        mediaCollectionView.register(
            UINib(nibName: String(describing: MediaCollectionViewCell.self),
                  bundle: nil), forCellWithReuseIdentifier: "mediaCollection")
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
    }

    public func configure(_ passingValues: [OverviewInformation]) {
        self.medias = passingValues
        DispatchQueue.main.async { [weak self] in
            self?.mediaCollectionView.reloadData()
        }
    }
}

extension MediaDetailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medias.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = mediaCollectionView.dequeueReusableCell(
            withReuseIdentifier: "mediaCollection", for: indexPath) as? MediaCollectionViewCell {

            let thumbnail = medias[indexPath.row].thumbnail

            guard let url = URL(string: thumbnail.path + "." + thumbnail.extension) else {
                return UICollectionViewCell()
            }
            ImageProvider.shared.fetchData(url: url) { image in
                DispatchQueue.main.async {
                    cell.configure(image: image)
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MediaDetailTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.imageDetailSize, height: Constant.imageDetailSize)
    }
}

extension MediaDetailTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.mediaTableViewCellDidTapCell(self, information: medias[indexPath.row])
    }
}
