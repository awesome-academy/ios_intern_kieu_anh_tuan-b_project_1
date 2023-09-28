//
//  ComicViewControllerTest.swift
//  MarvelAppTests
//
//  Created by Tobi on 27/09/2023.
//

import XCTest
@testable import MarvelApp

final class ComicViewControllerTest: XCTestCase {
    var comicVC: ComicViewController!

    override func setUpWithError() throws {
        comicVC = ComicViewController()
        comicVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        comicVC = nil
    }

    func testExample() throws {
        let scrollView = UIScrollView()
        let comics = [Comic(id: 123, title: "hello")]

        comicVC.comics = comics
        comicVC.viewDidLoad()
        comicVC.viewWillAppear(true)
        comicVC.viewWillDisappear(true)
        comicVC.addNotificationObserver()
        comicVC.getComics()
        comicVC.loadMore()
        comicVC.scrollViewDidScroll(scrollView)
        XCTAssertEqual(
            comicVC.tableView(comicVC.comicTableView,
                                 heightForRowAt: IndexPath(row: 0, section: 0)), Constant.comicCellHeight)
        XCTAssertEqual(comicVC.tableView(comicVC.comicTableView, numberOfRowsInSection: 0), comics.count)
        XCTAssertEqual(comicVC.tableView(comicVC.comicTableView,
                                         cellForRowAt: IndexPath(row: 0, section: 0)).backgroundColor, UIColor.clear)
    }
}
