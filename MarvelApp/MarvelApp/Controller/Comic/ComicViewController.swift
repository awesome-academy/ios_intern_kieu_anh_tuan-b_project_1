//
//  ComicViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

final class ComicViewController: UIViewController {
    @IBOutlet private weak var comicTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        comicTableView.register(
            UINib(nibName: String(describing: ComicTableViewCell.self),
                  bundle: nil), forCellReuseIdentifier: "comic")
        comicTableView.delegate = self
        comicTableView.dataSource = self
    }
}

extension ComicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.comicCellHeight
    }
}

extension ComicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: fix later
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = comicTableView.dequeueReusableCell(
            withIdentifier: "comic", for: indexPath) as? ComicTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}
