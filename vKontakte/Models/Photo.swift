//
//  Photo.swift
//  vKontakte
//
//  Created by Andrew on 26/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo {
    let photoURL: URL?
    var photo: [FriendPhotos] = []
    
    init(json: JSON) {
        let sizes = json["sizes"].arrayValue
        let biggestSize = sizes.reduce(sizes[0]) { currentTopSize, newSize -> JSON in
            let currentPoints = currentTopSize["width"].intValue * currentTopSize["height"].intValue
            let newSizePoints = newSize["width"].intValue * newSize["height"].intValue
            return currentPoints >= newSizePoints ? currentTopSize : newSize
        }
        self.photoURL = URL(string: biggestSize["url"].stringValue)
    }
}
