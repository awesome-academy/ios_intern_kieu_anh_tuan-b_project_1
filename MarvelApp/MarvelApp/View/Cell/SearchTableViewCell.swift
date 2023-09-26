//
//  SearchTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 17/09/2023.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {

    @IBOutlet private var resultImageView: UIImageView!
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var resultView: UIView!

    var goDetail: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        makeViewTappable()
    }

    private func makeViewTappable() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(resultViewTapped))
        resultView.isUserInteractionEnabled = true
        resultView.addGestureRecognizer(gesture)

    }

    public func configure(_ result: OverviewInformation) {
        resultLabel.text = result.name ?? result.fullName ?? result.title
        guard let url = URL(string: result.thumbnail.path + "." + result.thumbnail.extension) else {
            return
        }
        ImageProvider.shared.fetchData(url: url) { image in
            DispatchQueue.main.async { [weak self] in
                self?.resultImageView.image = image
            }
        }
    }

    @objc
    private func resultViewTapped(sender: UITapGestureRecognizer) {
        goDetail?()
    }
}
