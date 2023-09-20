//
//  ComicViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

final class ComicViewController: UIViewController {
    @IBOutlet private weak var comicTableView: UITableView!

    private var comics = [Comic]()

    override func viewDidLoad() {
        super.viewDidLoad()

        comicTableView.register(
            UINib(nibName: String(describing: ComicTableViewCell.self),
                  bundle: nil), forCellReuseIdentifier: "comic")
        comicTableView.delegate = self
        comicTableView.dataSource = self
        getComics()
    }

    private func getComics() {
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = comicTableView.dequeueReusableCell(
            withIdentifier: "comic", for: indexPath) as? ComicTableViewCell {
            cell.configure(comic: comics[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
