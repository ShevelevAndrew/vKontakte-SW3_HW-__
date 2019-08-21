//
//  FrendModel.swift
//  vKontakte
//
//  Created by Andrew on 19/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation


struct FriendModel: Codable {
    let response: Response
}
struct Response: Codable {
    let count: Int
    let items: [Item]
}
struct Item: Codable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool
    let sex: Int
    let bdate: String?
    let nickname, domain: String
    let country: Country
    let photo50: String
    let photo100: String
    let hasMobile: Int
    let mobilePhone, homePhone: String
    let online: Int
    let trackCode: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case sex, nickname, domain, country
        case bdate
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case hasMobile = "has_mobile"
        case mobilePhone = "mobile_phone"
        case homePhone = "home_phone"
        case online
        case trackCode = "track_code"
    }
}

// MARK: - Country
struct Country: Codable {
    let id: Int
    let title: String
}

