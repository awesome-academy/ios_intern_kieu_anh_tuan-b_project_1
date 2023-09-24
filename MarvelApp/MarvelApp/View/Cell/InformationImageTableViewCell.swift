//
//  InformationImageTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 21/09/2023.
//

import UIKit

final class InformationImageTableViewCell: UITableViewCell {

    @IBOutlet private weak var informationImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        informationImageView.addGradient(
            colors: [UIColor.black, UIColor.clear, UIColor.black],
            startPoint: CGPoint(x: 0.2, y: 1.0),
            endPoint: CGPoint(x: 0.2, y: 0))
    }

    func configure(information: OverviewInformation?) {
        titleLabel.text = information?.name ?? information?.fullName ?? information?.title

        guard let url = URL(string:
                                (information?.thumbnail.path ?? "") + "." +
                                (information?.thumbnail.extension ?? "")
        ) else {
            return
        }
        ImageProvider.shared.fetchData(url: url) { image in
            DispatchQueue.main.async { [weak self] in
                self?.informationImageView.image = image
            }
        }
    }
}
