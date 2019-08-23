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
    
    var friends: FriendModels!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure (with friend: FriendModels){
        friendNameLabel.text = friend.name
        let urlImage = URL(string: friend.image)
        friendImageView.kf.setImage(with: urlImage)
        likeCount.text = friend.likeCount
    }
}
