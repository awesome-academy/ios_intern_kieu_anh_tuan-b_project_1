//
//  PassingValue.swift
//  MarvelApp
//
//  Created by Tobi on 18/09/2023.
//

import Foundation

struct OverviewData: Codable {
    var data: OverviewResponse
}

struct OverviewResponse: Codable {
    var results: [OverviewInformation]
}

struct OverviewInformation: Codable {
    var id: Int
    var thumbnail: Thumbnail
    var name: String?
    var fullName: String?
    var title: String?
}
