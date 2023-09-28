//
//  FavoeriteViewControllerTest.swift
//  MarvelApp
//
//  Created by Tobi on 27/09/2023.
//

import XCTest
@testable import MarvelApp

final class FavoriteViewControllerTest: XCTestCase {
    var favoriteVC: FavoriteViewController!

    override func setUpWithError() throws {
        favoriteVC = FavoriteViewController()
        favoriteVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        favoriteVC = nil
    }

    func testExample() throws {
        favoriteVC.viewDidLoad()
        favoriteVC.viewWillAppear(true)
        favoriteVC.viewWillDisappear(true)
        favoriteVC.favoriteTableView.reloadData()
        favoriteVC.addNotificationObserver()
        favoriteVC.configureFavoriteTable()
        XCTAssertEqual(
            favoriteVC.tableView(favoriteVC.favoriteTableView,
                                 heightForRowAt: IndexPath(row: 0, section: 0)), Constant.searchResultHeight)
        XCTAssertEqual(favoriteVC.tableView(favoriteVC.favoriteTableView,
                                         cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier, "search")
    }
}
