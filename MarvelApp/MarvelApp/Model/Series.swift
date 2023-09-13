//
//  Seri.swift
//  MarvelApp
//
//  Created by Tobi on 13/09/2023.
//

import Foundation

struct SeriesData: Codable {
    var data: SeriesResponse
}

struct SeriesResponse: Codable {
    var results: [Series]
}

struct Series: Codable {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
    var startYear: Int?
    var endYear: Int?
}
