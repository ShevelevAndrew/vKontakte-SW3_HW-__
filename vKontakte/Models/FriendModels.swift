//
//  FriendModels.swift
//  vKontakte
//
//  Created by Andrew on 20/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class FriendModels: Object  {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    var likeCount: String = ""
    
    let photo = List<Photo>()
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.name = self.firstName + " " + self.lastName
        self.image = json["photo_100"].stringValue
        self.likeCount = "0"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
