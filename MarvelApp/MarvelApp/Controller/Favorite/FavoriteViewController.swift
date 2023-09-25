//
//  FavoriteViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

final class FavoriteViewController: UIViewController {

    @IBOutlet private weak var favoriteTableView: UITableView!

    private var favoriteItems = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureFavoriteTable()
        favoriteTableView.register(
            UINib(nibName: String(describing: SearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: "search")
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        addNotificationObserver()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(Constant.notificationToFavorite),
            object: nil, queue: nil) { [weak self] _ in
            self?.configureFavoriteTable()
        }
    }

    private func configureFavoriteTable() {
        DataPersistenceManager.shared.fetchFromDatabase { [weak self] result in
            switch result {
            case .success(let favoriteItems):
                self?.favoriteItems = favoriteItems
                self?.favoriteTableView.reloadData()
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription, controller: self)
            }
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.searchResultHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteItems.count
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteInDatabase(favoriteItems[indexPath.row]) { [weak self] result in
                switch result {
                case .success:
                    self?.showAlert(message: "Deleted", controller: self)
                    NotificationCenter.default.post(
                        name: NSNotification.Name(Constant.notificationToComic),
                        object: nil
                    )
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription, controller: self)
                }
                self?.favoriteItems.remove(at: indexPath.row)

                self?.favoriteTableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }

}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = favoriteTableView.dequeueReusableCell(
            withIdentifier: "search", for: indexPath) as? SearchTableViewCell {
            let item = favoriteItems[indexPath.row]

            let overviewInformation = OverviewInformation(
                id: Int(item.id),
                thumbnail: Thumbnail(path: item.thumbnailPath ?? Constant.emptyString,
                                     extension: item.thumbnailExtension ?? Constant.emptyString),
                name: item.title)
            cell.configure(overviewInformation)
            cell.goDetail = { [weak self] in
                guard let self = self else {
                    return
                }
                let detailVC = InformationDetailViewController()
                detailVC.setInformationData(overviewInformation: overviewInformation)
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            return cell
        }
        return UITableViewCell()
    }
}
