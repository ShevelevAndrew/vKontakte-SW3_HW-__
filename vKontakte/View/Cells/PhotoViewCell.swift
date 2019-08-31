//
//  PhotoViewCell.swift
//  vKontakte
//
//  Created by Andrew on 27/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    
    public func configurePhotos(with photo: Photo) {
        let urlPhoto = URL(string: photo.photoURL)
        img.kf.setImage(with: urlPhoto)
    }
}
