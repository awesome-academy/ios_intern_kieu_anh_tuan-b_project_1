//
//  ViewController.swift
//  MarvelApp
//
//  Created by Tobi on 11/09/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var homeTableView: UITableView!

    private var slides: [Character] = []

    private let sectionTitles = ["Heroes", "Creators", "Events", "Series"]

    override func viewDidLoad() {
        super.viewDidLoad()

        homeTableView.register(
            UINib(nibName: String(describing: ThumbnailTableViewCell.self),
                  bundle: nil), forCellReuseIdentifier: "thumbnail")
        homeTableView.register(UINib(nibName: String(describing: SlideTableViewCell.self),
                                     bundle: nil), forCellReuseIdentifier: "slideTable")

        homeTableView.delegate = self
        homeTableView.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func configureCell(result: Result<[OverviewInformation], Error>, cell: ThumbnailTableViewCell) {
        switch result {
        case .success(let value):
            cell.configure(value)
        case .failure(let error):
            self.showAlert(message: error.localizedDescription, controller: self)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
}

extension HomeViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count + 1
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == HomeSection.slide.rawValue {
            guard let slideCell = homeTableView.dequeueReusableCell(
                    withIdentifier: "slideTable", for: indexPath) as? SlideTableViewCell else {
                return UITableViewCell()
            }

            APICaller.shared.getInformation(dataType: CharactersData.self,
                                            categoryType: CategoryType.character) {  [weak self] result in
                switch result {
                case .success(let slidesData):
                    slideCell.configure(slidesData.data.results)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription, controller: self)
                }
            }
            return slideCell
        }

        guard let cell = homeTableView.dequeueReusableCell(
                withIdentifier: "thumbnail", for: indexPath) as? ThumbnailTableViewCell else {
            return UITableViewCell()
        }

        cell.delegate = self

        switch indexPath.section {
        case HomeSection.heroes.rawValue:
            APICaller.shared.getOverviewInformation(categoryType: CategoryType.character) { [weak self] result in
                self?.configureCell(result: result, cell: cell)
            }
        case HomeSection.creators.rawValue:
            APICaller.shared.getOverviewInformation(categoryType: CategoryType.creator) { [weak self] result in
                self?.configureCell(result: result, cell: cell)
            }
        case HomeSection.events.rawValue:
            APICaller.shared.getOverviewInformation(categoryType: CategoryType.event) { [weak self] result in
                self?.configureCell(result: result, cell: cell)
            }
        case HomeSection.series.rawValue:
            APICaller.shared.getOverviewInformation(categoryType: CategoryType.series) { [weak self] result in
                self?.configureCell(result: result, cell: cell)
            }
        default:
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: Constant.titleSize, weight: .semibold)
        header.textLabel?.frame = CGRect(
            x: header.bounds.origin.x + Constant.paddingHorizontal,
            y: header.bounds.origin.y,
            width: Constant.sectionLabelWidth,
            height: header.bounds.height
        )
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section != HomeSection.slide.rawValue ? sectionTitles[section - 1] : nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section != HomeSection.slide.rawValue ? Constant.thumbnailHeight : Constant.thumbnailHeight * 2
    }
}

extension HomeViewController: ThumbnailTableViewCellDelegate {
    func thumbnailTableViewCellDidTapCell(_ cell: ThumbnailTableViewCell, information: OverviewInformation) {
        let detailVC = InformationDetailViewController()
        detailVC.id = information.id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
