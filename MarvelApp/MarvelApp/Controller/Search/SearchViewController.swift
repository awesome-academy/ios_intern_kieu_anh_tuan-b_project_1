//
//  SearchViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var characterButton: UIButton!
    @IBOutlet private weak var creatorButton: UIButton!
    @IBOutlet private weak var comicButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.register(
            UINib(nibName: String(describing: SearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: "search")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        setupUI()
    }

    private func setupUI() {
        searchBar.customizeView()
        characterButton.applyBorderOutline()
        creatorButton.applyBorderOutline()
        comicButton.applyBorderOutline()
        characterButton.setSelected()
    }

    private func setSelectedButton(_ selectedButton: UIButton) {
        let buttons = [characterButton, creatorButton, comicButton]
        for button in buttons {
            button == selectedButton ? button?.setSelected() : button?.setDeselected()
        }
    }

    @IBAction private func characterButtonTapped(_ sender: Any) {
        setSelectedButton(characterButton)
    }

    @IBAction private func creatorButtonTapped(_ sender: Any) {
        setSelectedButton(creatorButton)
    }

    @IBAction private func comicButtonTapped(_ sender: Any) {
        setSelectedButton(comicButton)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: fix later
        return 100
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: fix later
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = searchTableView.dequeueReusableCell(
            withIdentifier: "search", for: indexPath) as? SearchTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}
