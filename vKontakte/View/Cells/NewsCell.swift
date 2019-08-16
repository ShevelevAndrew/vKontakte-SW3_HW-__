//
//  NewsCell.swift
//  vKontakte
//
//  Created by Andrew on 10/06/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    //static let reuseIdentifier = "NewsCell"
    static var reuseId: String = "NewsCell"
    
    @IBOutlet weak var imageFriends: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
