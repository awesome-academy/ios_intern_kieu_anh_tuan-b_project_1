//
//  SearchViewController.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var characterButton: UIButton!
    @IBOutlet weak var creatorButton: UIButton!
    @IBOutlet weak var comicButton: UIButton!

    var searchResult: [OverviewInformation] = []
    var searchText = ""
    var category = CategoryType.character
    var defaultLimit = Constant.defaultLimit

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        searchTableView.register(
            UINib(nibName: String(describing: SearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: "search")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
        setupUI()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func setupUI() {
        searchBar.customizeView()
        characterButton.applyBorderOutline()
        creatorButton.applyBorderOutline()
        comicButton.applyBorderOutline()
        characterButton.setSelected()
    }

    func setSelectedButton(_ selectedButton: UIButton) {
        let buttons = [characterButton, creatorButton, comicButton]
        for button in buttons {
            button == selectedButton ? button?.setSelected() : button?.setDeselected()
        }
    }

    func getSearchResult() {
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

    func loadMore() {
        let queue = DispatchQueue(label: "loadMore", qos: .utility)
        queue.async { [unowned self] in
            APICaller.shared.loadMoreOverviewInformation(loadMore: String(defaultLimit),
                                                         categoryType: category) {  [weak self] result in
                switch result {
                case .success(let results):
                    self?.searchResult.append(contentsOf: results)
                    DispatchQueue.main.async { [weak self] in
                        self?.searchTableView.reloadData()
                    }
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription, controller: self)
                }
            }
        }

    }

    @IBAction func characterButtonTapped(_ sender: Any) {
        category = CategoryType.character
        setSelectedButton(characterButton)
        getSearchResult()
    }

    @IBAction func creatorButtonTapped(_ sender: Any) {
        category = CategoryType.creator
        setSelectedButton(creatorButton)
        getSearchResult()
    }

    @IBAction func comicButtonTapped(_ sender: Any) {
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
            cell.goDetail = { [weak self] in
                guard let self = self else {
                    return
                }
                let detailVC = InformationDetailViewController()
                detailVC.setInformationData(overviewInformation: self.searchResult[indexPath.row])
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            return cell
        }
        return UITableViewCell()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (searchTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            let loadStep = Constant.loadStep
            self.defaultLimit += loadStep
            self.loadMore()
        }
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
