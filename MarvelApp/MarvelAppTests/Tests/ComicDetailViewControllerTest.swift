//
//  ComicDetailViewControllerTest.swift
//  MarvelAppTests
//
//  Created by Tobi on 27/09/2023.
//

import XCTest
@testable import MarvelApp

final class ComicDetailViewControllerTest: XCTestCase {
    var comicDetailVC: ComicDetailViewController!

    override func setUpWithError() throws {
        comicDetailVC = ComicDetailViewController()
        comicDetailVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        comicDetailVC = nil
    }

    func testExample() throws {
        let comic = Comic(id: 123, images: [
            Thumbnail(path: "", extension: "")
        ])

        comicDetailVC.comic = comic

        comicDetailVC.viewDidLoad()
        comicDetailVC.viewWillAppear(true)
        comicDetailVC.viewWillDisappear(true)
        comicDetailVC.setComic(comic)
        comicDetailVC.backButtonTapped(comicDetailVC.backButton!)
        XCTAssertEqual(
            comicDetailVC.tableView(comicDetailVC.comicPreviewTableView,
                                 heightForRowAt: IndexPath(row: 0, section: 0)), Constant.comicPreviewHeight)
        XCTAssertEqual(comicDetailVC.tableView(comicDetailVC.comicPreviewTableView, numberOfRowsInSection: 0), 1)
        XCTAssertEqual(comicDetailVC.tableView(
                        comicDetailVC.comicPreviewTableView,
                        cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier, "comicPreview")
    }
}
