//
//  SearchViewControllerTest.swift
//  MarvelAppUITests
//
//  Created by Tobi on 27/09/2023.
//

import XCTest
@testable import MarvelApp

final class SearchViewControllerTest: XCTestCase {
    var searchVC: SearchViewController!

    override func setUpWithError() throws {
        searchVC = SearchViewController()
        searchVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        searchVC = nil
    }

    func testExample() throws {
        let searchResult = [OverviewInformation(id: 123, thumbnail: Thumbnail(path: "", extension: ""))]

        let scrollView = UIScrollView()

        searchVC.searchResult = searchResult

        searchVC.viewDidLoad()
        searchVC.viewWillAppear(true)
        searchVC.viewWillDisappear(true)
        searchVC.setupUI()
        searchVC.getSearchResult()
        searchVC.loadMore()
        searchVC.setSelectedButton(searchVC.characterButton)
        searchVC.characterButtonTapped(searchVC.characterButton!)
        searchVC.creatorButtonTapped(searchVC.creatorButton!)
        searchVC.comicButtonTapped(searchVC.comicButton!)
        searchVC.scrollViewDidScroll(scrollView)
        XCTAssertEqual(
            searchVC.tableView(searchVC.searchTableView,
                                 heightForRowAt: IndexPath(row: 0, section: 0)), Constant.searchResultHeight)
        XCTAssertEqual(searchVC.tableView(searchVC.searchTableView,
                                         cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier, "search")
    }
}
