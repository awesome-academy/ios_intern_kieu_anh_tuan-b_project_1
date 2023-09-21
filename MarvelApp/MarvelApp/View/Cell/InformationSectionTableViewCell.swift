//
//  InformationSectionTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 21/09/2023.
//

import UIKit

final class InformationSectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var sectionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(title: String?) {
        sectionLabel.text = title
    }
}
