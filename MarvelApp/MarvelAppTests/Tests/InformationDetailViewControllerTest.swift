//
//  InformationDetailViewControllerTest.swift
//  MarvelAppTests
//
//  Created by Tobi on 27/09/2023.
//

import XCTest
@testable import MarvelApp

final class InformationDetailViewControllerTest: XCTestCase {
    var informationDetailVC: InformationDetailViewController!

    override func setUpWithError() throws {
        informationDetailVC = InformationDetailViewController()
        informationDetailVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        informationDetailVC = nil
    }

    func testExample() throws {
        let information = OverviewInformation(id: 123, thumbnail: Thumbnail(path: "", extension: ""))
        let detailTableViewData = [CellData(opened: false, title: DetailSectionLabel.story.rawValue, sectionDetail: ""),
                                   CellData(opened: false, title: "2", sectionDetail: "")]

        informationDetailVC.detailTableViewData = detailTableViewData
        informationDetailVC.overviewInformation = information
        informationDetailVC.viewDidLoad()
        informationDetailVC.viewWillAppear(true)
        informationDetailVC.viewWillDisappear(true)
        informationDetailVC.configureData()
        informationDetailVC.backButtonTapped(informationDetailVC.backButton!)
        informationDetailVC.setInformationData(overviewInformation: information)
        XCTAssertEqual(
            informationDetailVC.tableView(informationDetailVC.detailTableView,
                                 heightForRowAt: IndexPath(row: 0, section: 0)), Constant.detailImageHeight)
        XCTAssertEqual(informationDetailVC.numberOfSections(in: informationDetailVC.detailTableView), 3)
        XCTAssertEqual(informationDetailVC.tableView(
                        informationDetailVC.detailTableView,
                        cellForRowAt: IndexPath(row: 0, section: 0)).reuseIdentifier, "informationImage")
        XCTAssertEqual(informationDetailVC.tableView(
                        informationDetailVC.detailTableView,
                        cellForRowAt: IndexPath(row: 0, section: 1)).reuseIdentifier, "informationSection")
        XCTAssertEqual(informationDetailVC.tableView(
                        informationDetailVC.detailTableView,
                        cellForRowAt: IndexPath(row: 1, section: 1)).reuseIdentifier, "informationDetail")
        XCTAssertEqual(informationDetailVC.tableView(
                        informationDetailVC.detailTableView,
                        cellForRowAt: IndexPath(row: 1, section: 2)).reuseIdentifier, "mediaTable")
    }
}
