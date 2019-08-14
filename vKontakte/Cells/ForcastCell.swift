//
//  ForcastCell.swift
//  vKontakte
//
//  Created by Andrew on 23/05/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class ForcastCell: UICollectionViewCell {
    static let reuseIdentifier = "ForcastCell"
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImageView: UIImageView!
    
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: Likebutton!
 
    @IBOutlet weak var fotoColection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
