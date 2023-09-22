//
//  InformationDetailViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

// TODO: Test, fix later
struct CellData {
    var opened: Bool
    var title: String
    var sectionData: [String]
}

final class InformationDetailViewController: UIViewController {
    @IBOutlet private weak var detailTableView: UITableView!

    // TODO: Test Data, fix later
    private var detailTableViewData = [
        CellData(opened: false, title: "Storyline", sectionData: ["Cell1", "Cell2", "Cell3", "Cell4"]),
        CellData(opened: false, title: "Comics", sectionData: ["Cell1", "Cell2"]),
        CellData(opened: false, title: "Series", sectionData: ["Cell1", "Cell2", "Cell3"])
    ]

    private var nibFiles = [
        NibFile(nibName: String(describing: InformationImageTableViewCell.self), identifier: "informationImage"),
        NibFile(nibName: String(describing: InformationSectionTableViewCell.self), identifier: "informationSection"),
        NibFile(nibName: String(describing: InformationDetailTableViewCell.self), identifier: "informationDetail")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        for nib in nibFiles {
            detailTableView.register(UINib(nibName: nib.nibName, bundle: nil), forCellReuseIdentifier: nib.identifier)
        }
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }

    @IBAction private func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension InformationDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == DetailSection.image.rawValue { return Constant.detailImageHeight }
        return Constant.detailSectionHeight
    }
}

extension InformationDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailTableViewData.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > DetailSection.image.rawValue && detailTableViewData[section - 1].opened {
            return detailTableViewData[section - 1].sectionData.count + 1
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == DetailSection.image.rawValue {
            if let cell = detailTableView.dequeueReusableCell(
                withIdentifier: "informationImage", for: indexPath) as? InformationImageTableViewCell {
                return cell
            }
            return UITableViewCell()
        }

        if indexPath.row == 0 {
            if let cell = detailTableView.dequeueReusableCell(
                withIdentifier: "informationSection", for: indexPath) as? InformationSectionTableViewCell {
                cell.configure(title: detailTableViewData[indexPath.section - 1].title)
                cell.layer.addBorder(edge: UIRectEdge.bottom, color: .white, thickness: 1, horizontalPadding: 16)
                return cell
            }
            return UITableViewCell()
        } else {
            if let cell = detailTableView.dequeueReusableCell(
                withIdentifier: "informationDetail", for: indexPath) as? InformationDetailTableViewCell {
                cell.configure(title: detailTableViewData[indexPath.section - 1].sectionData[indexPath.row - 1])
                return cell
            }
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == DetailSection.image.rawValue {
            return
        }
        if detailTableViewData[indexPath.section - 1].opened {
            detailTableViewData[indexPath.section - 1].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .automatic)
        } else {
            detailTableViewData[indexPath.section - 1].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .automatic)
        }
    }
}
