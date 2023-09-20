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

    private var searchResult: [OverviewInformation] = []
    private var searchText = ""
    private var category = CategoryType.character

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        searchTableView.register(
            UINib(nibName: String(describing: SearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: "search")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
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

    private func getSearchResult() {
        APICaller.shared.getOverviewInformation(searchValue: searchText,
                                                categoryType: category) { [weak self] result in
            switch result {
            case .success(let searchResponse):
                self?.searchResult = searchResponse
                DispatchQueue.main.async { [weak self] in
                    self?.searchTableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription, controller: self)
            }
        }
    }

    @IBAction private func characterButtonTapped(_ sender: Any) {
        category = CategoryType.character
        setSelectedButton(characterButton)
        getSearchResult()
    }

    @IBAction private func creatorButtonTapped(_ sender: Any) {
        category = CategoryType.creator
        setSelectedButton(creatorButton)
        getSearchResult()
    }

    @IBAction private func comicButtonTapped(_ sender: Any) {
        category = CategoryType.comic
        setSelectedButton(comicButton)
        getSearchResult()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.searchResultHeight
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = searchTableView.dequeueReusableCell(
            withIdentifier: "search", for: indexPath) as? SearchTableViewCell {
            cell.configure(searchResult[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getSearchResult()
    }
}
