//
//  Photo.swift
//  vKontakte
//
//  Created by Andrew on 26/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var owner_id = 0
    @objc dynamic var photoURL: String = "" //URL?
    
    let friend = LinkingObjects(fromType: FriendModels.self, property: "photo")
  //  var photo: [FriendPhotos] = []
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.owner_id = json["owner_id"].intValue
        let sizes = json["sizes"].arrayValue
        let biggestSize = sizes.reduce(sizes[0]) { currentTopSize, newSize -> JSON in
            let currentPoints = currentTopSize["width"].intValue * currentTopSize["height"].intValue
            let newSizePoints = newSize["width"].intValue * newSize["height"].intValue
            return currentPoints >= newSizePoints ? currentTopSize : newSize
        }
        self.photoURL = biggestSize["url"].stringValue // URL(string: biggestSize["url"].stringValue)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
