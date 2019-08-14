//
//  CustomTableviewCell.swift
//  vKontakte
//
//  Created by Andrew on 07/06/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static var reuseId: String = "CustomFriendCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var friendImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
