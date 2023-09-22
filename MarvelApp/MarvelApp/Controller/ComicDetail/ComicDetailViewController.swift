//
//  ComicDetailViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

final class ComicDetailViewController: UIViewController {
    var comic: Comic?

    @IBOutlet private weak var comicPreviewTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        comicPreviewTableView.register(
            UINib(nibName: String(describing: ComicPreviewTableViewCell.self),
                  bundle: nil), forCellReuseIdentifier: "comicPreview")
        comicPreviewTableView.delegate = self
        comicPreviewTableView.dataSource = self
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ComicDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.comicPreviewHeight
    }
}

extension ComicDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comic?.images?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = comicPreviewTableView.dequeueReusableCell(
            withIdentifier: "comicPreview", for: indexPath) as? ComicPreviewTableViewCell {
            cell.configure(thumbnail: comic?.images?[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
