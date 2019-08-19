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











//class FriendModel: Codable {
//    let response: Response
//}
//
//class Response: Codable {
//    let count: Int
//    let items = [Items]()
//}
//
//class Items : Codable {
//    let first_name: String
//    let last_name: String
//    let sex: Int
//    let nickname: String
//    let photo_50: String
//    let photo_100: String
//    let mobile_phone: String
//}
//
//
//
//
//{
//    "response": {
//        "count": 1,
//        "items": [
//        {
//        "id": 52347755,
//        "first_name": "Виктория",
//        "last_name": "Шевелева",
//        "is_closed": false,
//        "can_access_closed": true,
//        "sex": 1,
//        "nickname": "",
//        "domain": "id52347755",
//        "bdate": "3.9",
//        "country": {
//        "id": 1,
//        "title": "Россия"
//        },
//        "photo_50": "https://sun9-55.userapi.com/c845016/v845016416/10452f/xFNdoND7_Jo.jpg?ava=1",
//        "photo_100": "https://sun9-39.userapi.com/c845016/v845016416/10452e/l4ZY64w68j4.jpg?ava=1",
//        "has_mobile": 1,
//        "mobile_phone": "",
//        "home_phone": "",
//        "online": 0,
//        "track_code": "77f35663foiXh76rMo44Rw6BtUFmoYDMmYtFvWX8PTxtGWw52FQT45rh0K1h2ztAOQE4g_vB4MGOkA"
//        }
//        ]
//    }
//}
