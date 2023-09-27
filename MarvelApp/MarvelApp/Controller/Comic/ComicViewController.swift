//
//  ComicViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

final class ComicViewController: UIViewController {
    @IBOutlet weak var comicTableView: UITableView!

    var comics = [Comic]()
    private var defaultLimit = Constant.defaultLimit

    override func viewDidLoad() {
        super.viewDidLoad()

        comicTableView.register(
            UINib(nibName: String(describing: ComicTableViewCell.self),
                  bundle: nil), forCellReuseIdentifier: "comic")
        comicTableView.delegate = self
        comicTableView.dataSource = self
        getComics()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        addNotificationObserver()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func addNotificationObserver() {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(Constant.notificationToComic),
            object: nil, queue: nil) { [weak self] _ in
            self?.comicTableView.reloadData()
        }
    }

    func getComics() {
        APICaller.shared.getInformation(dataType: ComicsData.self,
                                        categoryType: CategoryType.comic) { [weak self] result in
            switch result {
            case .success(let comicsData):
                self?.comics = comicsData.data.results
                DispatchQueue.main.async { [weak self] in
                    self?.comicTableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription, controller: self)
            }
        }
    }

    func loadMore() {
        let queue = DispatchQueue(label: "loadMoreComic", qos: .utility)
        queue.async { [unowned self] in
            APICaller.shared.loadMoreInformation(loadMore: String(defaultLimit), dataType: ComicsData.self,
                                                 categoryType: CategoryType.comic) {  [weak self] result in
                switch result {
                case .success(let comics):
                    self?.comics.append(contentsOf: comics.data.results)
                    DispatchQueue.main.async { [weak self] in
                        self?.comicTableView.reloadData()
                    }
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription, controller: self)
                }
            }
        }
    }

}

extension ComicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.comicCellHeight
    }
}

extension ComicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (comicTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            let loadStep = Constant.loadStep
            self.defaultLimit += loadStep
            self.loadMore()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = comicTableView.dequeueReusableCell(
            withIdentifier: "comic", for: indexPath) as? ComicTableViewCell {
            let comic = self.comics[indexPath.row]

            var isFavorite = DataPersistenceManager.shared.checkEntityExists(id: comic.id)
            cell.configure(comic: comic)
            cell.configureFavorite(isFavorite: isFavorite)
            cell.goDetail = { [weak self] in
                let comicDetail = ComicDetailViewController()
                comicDetail.setComic(comic)
                self?.navigationController?.pushViewController(comicDetail, animated: true)
            }

            cell.addToFavorite = { [weak self] in
                if isFavorite {
                    self?.showAlert(message: "Item is already in favorite list", controller: self)
                } else {
                    DataPersistenceManager.shared.addToFavourite(
                        OverviewInformation(
                            id: comic.id,
                            thumbnail: comic.thumbnail!,
                            title: comic.title
                        )) { result in
                        switch result {
                        case .success:
                            self?.showAlert(message: "Added to favorite", controller: self)
                            isFavorite = !isFavorite
                            cell.configureFavorite(isFavorite: isFavorite)
                            NotificationCenter.default.post(
                                name: NSNotification.Name(Constant.notificationToFavorite),
                                object: nil
                            )
                        case .failure(let error):
                            self?.showAlert(message: error.localizedDescription, controller: self)
                        }
                    }
                }
            }

            return cell
        }
        return UITableViewCell()
    }
}
