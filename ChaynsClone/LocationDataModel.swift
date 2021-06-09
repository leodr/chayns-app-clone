//
//  File.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 07.06.21.
//

import Foundation

// MARK: - LocationData

struct LocationData: Codable {
    let locations: [Location]
    let lastCheck: String
}

// MARK: - Location

struct Location: Codable {
    let lastLogin, lastVisit: String?
    let totalVisits: Int
    let isFavourite: Bool?
    let sortID: Int
    let creationTime: String
    let id: Int
    let siteID, domain, name: String
    let lat, long: Double
    let color: String
    let colorMode: Int
    let category: String?

    enum CodingKeys: String, CodingKey {
        case lastLogin, lastVisit, totalVisits, isFavourite
        case sortID = "sortId"
        case creationTime, id
        case siteID = "siteId"
        case domain, name, lat, long, color, colorMode, category
    }
}
