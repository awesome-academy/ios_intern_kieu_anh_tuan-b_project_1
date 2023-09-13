//
//  Event.swift
//  MarvelApp
//
//  Created by Tobi on 13/09/2023.
//

import Foundation

struct EventsData: Codable {
    var data: EventsResponse
}

struct EventsResponse: Codable {
    var results: [Event]
}

struct Event: Codable {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
}
