//
//  Creator.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import Foundation

struct CreatorsData: Codable {
    var data: CreatorsResponse
}

struct CreatorsResponse: Codable {
    var results: [Creator]
}

struct Creator: Codable {
    var id: Int
    var fullName: String
    var thumbnail: Thumbnail?
}
