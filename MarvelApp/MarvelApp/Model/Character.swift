//
//  Character.swift
//  MarvelApp
//
//  Created by Tobi on 12/09/2023.
//

import Foundation

struct CharactersData: Codable {
    var data: CharactersResponse
}

struct CharactersResponse: Codable {
    var results: [Character]
}

struct Character: Codable {
    var id: Int
    var title: String?
    var description: String?
    var startYear: Int?
    var endYear: Int?
    var thumbnail: Thumbnail?
}
