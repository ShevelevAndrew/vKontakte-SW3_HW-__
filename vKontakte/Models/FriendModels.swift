//
//  FriendModels.swift
//  vKontakte
//
//  Created by Andrew on 20/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import SwiftyJSON

class FriendModels {
    let firstName: String
    let lastName: String
    let name: String
    let image: String
    let likeCount: String
    
    init(_ json: JSON) {
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.name = self.firstName + " " + self.lastName
        self.image = json["photo_100"].stringValue
        self.likeCount = "0"
    }
}
