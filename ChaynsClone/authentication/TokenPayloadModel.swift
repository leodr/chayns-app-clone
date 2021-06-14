//
//  TokenPayloadModel.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 09.06.21.
//

import Foundation

// MARK: - TokenPayload

struct TokenPayload: Codable {
    let jti: String
    let sub: String
    let type: Int
    let exp: String
    let iat: String
    let locationID: Int
    let siteID: String
    let isAdmin: Bool
    let tobitUserID: Int
    let personID: String
    let firstName: String
    let lastName: String
    let prov: Int

    enum CodingKeys: String, CodingKey {
        case jti = "jti"
        case sub = "sub"
        case type = "type"
        case exp = "exp"
        case iat = "iat"
        case locationID = "LocationID"
        case siteID = "SiteID"
        case isAdmin = "IsAdmin"
        case tobitUserID = "TobitUserID"
        case personID = "PersonID"
        case firstName = "FirstName"
        case lastName = "LastName"
        case prov = "prov"
    }
}
