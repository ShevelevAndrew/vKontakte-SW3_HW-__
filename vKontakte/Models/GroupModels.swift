//
//  GroupModels.swift
//  vKontakte
//
//  Created by Andrew on 22/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import SwiftyJSON

class GroupModels {
    let id: Int
    let name: String
    let image: String
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.image = json["photo_200"].stringValue
    }
}


//"response": {
//    "count": 5,
//    "items": [
//    {
//    "id": 72469899,
//    "name": "Swift, xCode, Apple News, IPhone, iPad",
//    "screen_name": "swiftlanguage4you",
//    "is_closed": 0,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://pp.userapi.com/DpUYfRn32SRb8fXhHIkHpZjaT4nYguZPZunDLA/u2fDL_ZJ4s4.jpg?ava=1",
//    "photo_100": "https://pp.userapi.com/y4RW9c0hk2N60oLA8SB0wLhz8ei9XdQX7uWQOA/6MELf1nuZS0.jpg?ava=1",
//    "photo_200": "https://pp.userapi.com/nGKAQJK-NI3ou4NWUrC8miUgW6XMGttlIqfPzA/5B2weJbjgYA.jpg?ava=1"
//    },
//    {
//    "id": 49234971,
//    "name": "Xcode",
//    "screen_name": "xcodefornoobs",
//    "is_closed": 0,
//    "type": "page",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://pp.userapi.com/grB9TGTx3FzqL5KY4jhozAaYrPPJGNkrd350Og/-GzMnUMsOWQ.jpg?ava=1",
//    "photo_100": "https://pp.userapi.com/3ewgQRVUAagAejbonjDqSZ4iSjsHtWncigA9nw/Qpx07CKJFGQ.jpg?ava=1",
//    "photo_200": "https://pp.userapi.com/kMWmab0c-KhG2k4uLRfbiqNm5hSzJ619BZQfHg/EfhlsdvnK-U.jpg?ava=1"
//    },
//    {
//    "id": 75972837,
//    "name": "XCode,Objective - C , Swift  для новичков.",
//    "screen_name": "xcode_education",
//    "is_closed": 0,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://pp.userapi.com/D5fALziwYPrtNIafM6lYlUh7uTGkY8V_57lveA/3lXOunhG7CA.jpg?ava=1",
//    "photo_100": "https://pp.userapi.com/FczUxK3y94Otpn9q3C8H1TYJoykhYpAe5bVkyQ/XTmqKHCb01w.jpg?ava=1",
//    "photo_200": "https://pp.userapi.com/ynN3cqBv8OaT-FmQALyZDAE3oa-Nf4aDS1kmAw/PIbw3VJIhOQ.jpg?ava=1"
//    },
//    {
//    "id": 47069671,
//    "name": "Xcode Community",
//    "screen_name": "xcodecommunity",
//    "is_closed": 0,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://pp.userapi.com/HT4fWwDZloaBg3qQg1wbalP2Gsm8Xj0f2pIPPA/l3HQG_hOsjA.jpg?ava=1",
//    "photo_100": "https://pp.userapi.com/vcBoF0fxkOWfjNCoOZ5j9iFEDlXJZ4FR9wnOWg/Qz1xvvCczdw.jpg?ava=1",
//    "photo_200": "https://pp.userapi.com/Aux9NHRpNJe-wOQOcqxMyhOc2uWT_TYLIkJ2Gg/6IPXopxVa98.jpg?ava=1"
//    },
//    {
//    "id": 182681923,
//    "name": "Автоматизация в ХМАО ЯНАО",
//    "screen_name": "club182681923",
//    "is_closed": 0,
//    "type": "page",
//    "is_admin": 1,
//    "admin_level": 3,
//    "is_member": 1,
//    "is_advertiser": 1,
//    "photo_50": "https://vk.com/images/community_50.png?ava=1",
//    "photo_100": "https://vk.com/images/community_100.png?ava=1",
//    "photo_200": "https://vk.com/images/community_200.png?ava=1"
//    }
//    ]
//}
//}
