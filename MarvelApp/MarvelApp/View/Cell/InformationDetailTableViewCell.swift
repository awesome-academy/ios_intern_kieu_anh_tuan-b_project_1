//
//  InformationDetailTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 21/09/2023.
//

import UIKit

final class InformationDetailTableViewCell: UITableViewCell {

    @IBOutlet private var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(title: String) {
        detailLabel.text = title
    }

}
