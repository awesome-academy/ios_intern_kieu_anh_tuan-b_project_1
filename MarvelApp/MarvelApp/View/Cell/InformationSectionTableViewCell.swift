//
//  InformationSectionTableViewCell.swift
//  MarvelApp
//
//  Created by Tobi on 21/09/2023.
//

import UIKit

final class InformationSectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var sectionLabel: UILabel!
    @IBOutlet private weak var expandButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(title: String?, isOpen: Bool) {
        sectionLabel.text = title
        expandButton.setImage(UIImage(systemName: isOpen ? "chevron.up" : "chevron.down"), for: .normal)
    }
}
