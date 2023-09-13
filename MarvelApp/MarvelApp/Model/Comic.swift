//
//  Comic.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import Foundation

struct ComicsData: Codable {
    var data: ComicsResponse
}

struct ComicsResponse: Codable {
    var results: [Comic]
}

struct Comic: Codable {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
    var images: [Thumbnail]?
    var prices: [Price]?
}

struct Price: Codable {
    var type: String
    var price: Float
}
