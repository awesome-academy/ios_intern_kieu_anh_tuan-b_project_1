//
//  InformationDetailViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

struct CellData {
    var opened: Bool
    var title: String
    var sectionDetail: String
}

final class InformationDetailViewController: UIViewController {
    @IBOutlet private weak var detailTableView: UITableView!

    private var detailTableViewData = [CellData]()

    private var overviewInformation: OverviewInformation?

    private var nibFiles = [
        NibFile(nibName: String(describing: InformationImageTableViewCell.self), identifier: "informationImage"),
        NibFile(nibName: String(describing: InformationSectionTableViewCell.self), identifier: "informationSection"),
        NibFile(nibName: String(describing: InformationDetailTableViewCell.self), identifier: "informationDetail"),
        NibFile(nibName: String(describing: MediaDetailTableViewCell.self), identifier: "mediaTable")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        for nib in nibFiles {
            detailTableView.register(UINib(nibName: nib.nibName, bundle: nil), forCellReuseIdentifier: nib.identifier)
        }
        configureData()
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }

    public func setInformationData(overviewInformation: OverviewInformation?) {
        self.overviewInformation = overviewInformation
    }

    @IBAction private func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    private func configureData() {
        if let description = overviewInformation?.description, description != "" {
            detailTableViewData.append(
                CellData(
                    opened: false,
                    title: DetailSectionLabel.story.rawValue,
                    sectionDetail: description
                )
            )
        }
        if let comics = overviewInformation?.comics {
            detailTableViewData.append(
                CellData(
                    opened: false,
                    title: DetailSectionLabel.comic.rawValue,
                    sectionDetail: comics.collectionURI ?? comics.resourceURI ?? Constant.emptyString
                )
            )
        }
        if let creators = overviewInformation?.creators {
            detailTableViewData.append(
                CellData(
                    opened: false,
                    title: DetailSectionLabel.creator.rawValue,
                    sectionDetail: creators.collectionURI ?? creators.resourceURI ?? Constant.emptyString
                )
            )
        }
        if let characters = overviewInformation?.characters {
            detailTableViewData.append(
                CellData(
                    opened: false,
                    title: DetailSectionLabel.character.rawValue,
                    sectionDetail: characters.collectionURI ?? characters.resourceURI ?? Constant.emptyString
                )
            )
        }
        if let series = overviewInformation?.series {
            detailTableViewData.append(
                CellData(
                    opened: false,
                    title: DetailSectionLabel.series.rawValue,
                    sectionDetail: series.collectionURI ?? series.resourceURI ?? Constant.emptyString
                )
            )
        }
        if let events = overviewInformation?.events {
            detailTableViewData.append(
                CellData(
                    opened: false,
                    title: DetailSectionLabel.event.rawValue,
                    sectionDetail: events.collectionURI ?? events.resourceURI ?? Constant.emptyString
                )
            )
        }
    }

    private func configureCell(result: Result<[OverviewInformation], Error>, cell: MediaDetailTableViewCell) {
        switch result {
        case .success(let value):
            cell.configure(value)
        case .failure(let error):
            self.showAlert(message: error.localizedDescription, controller: self)
        }
    }
}

extension InformationDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == DetailSection.image.rawValue {
            return Constant.detailImageHeight
        }
        return UITableView.automaticDimension
    }
}

extension InformationDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailTableViewData.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > DetailSection.image.rawValue && detailTableViewData[section - 1].opened {
            return Constant.expandRows
        } else {
            return Constant.defaultRows
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == DetailSection.image.rawValue {
            if let cell = detailTableView.dequeueReusableCell(
                withIdentifier: "informationImage", for: indexPath) as? InformationImageTableViewCell {
                cell.configure(information: overviewInformation)
                return cell
            }
            return UITableViewCell()
        }

        if indexPath.row == 0 {
            if let cell = detailTableView.dequeueReusableCell(
                withIdentifier: "informationSection", for: indexPath) as? InformationSectionTableViewCell {
                let sectionData = detailTableViewData[indexPath.section - 1]
                cell.configure(title: sectionData.title, isOpen: sectionData.opened)
                return cell
            }
            return UITableViewCell()
        } else {
            if detailTableViewData[indexPath.section - 1].title == DetailSectionLabel.story.rawValue {
                if let cell = detailTableView.dequeueReusableCell(
                    withIdentifier: "informationDetail", for: indexPath) as? InformationDetailTableViewCell {
                    cell.configure(title: detailTableViewData[indexPath.section - 1].sectionDetail)
                    return cell
                }
            } else {
                if let cell = detailTableView.dequeueReusableCell(
                    withIdentifier: "mediaTable", for: indexPath) as? MediaDetailTableViewCell {

                    APICaller.shared.getSectionDetail(
                        url: detailTableViewData[indexPath.section - 1].sectionDetail
                    ) { [weak self] result in
                        self?.configureCell(result: result, cell: cell)
                    }
                    cell.delegate = self
                    return cell
                }
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

extension InformationDetailViewController: MediaTableViewCellDelegate {
    func mediaTableViewCellDidTapCell(_ cell: MediaDetailTableViewCell, information: OverviewInformation) {
        let detailVC = InformationDetailViewController()
        detailVC.overviewInformation = information
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
