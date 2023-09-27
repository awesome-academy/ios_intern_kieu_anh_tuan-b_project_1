//
//  HomeViewControllerTest.swift
//  MarvelApp
//
//  Created by Tobi on 27/09/2023.
//

import XCTest
@testable import MarvelApp

final class HomeViewControllerTest: XCTestCase {
    var homeVC: HomeViewController!

    override func setUpWithError() throws {
        homeVC = HomeViewController()
        homeVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        homeVC = nil
    }

    func testExample() throws {
        let slides = [Character(id: 123)]
        homeVC.slides = slides

        homeVC.viewDidLoad()
        homeVC.viewWillAppear(true)
        homeVC.viewWillDisappear(true)
        XCTAssertEqual(homeVC.tableView(
                        homeVC.homeTableView,
                        cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier, "slideTable")
    }
}
