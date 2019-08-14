//
//  GroopCell.swift
//  vKontakte
//
//  Created by Andrew on 23/05/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class GroopCell: UITableViewCell {

    static let reuseIdentifier = "GroopCell"
    
    @IBOutlet weak var groopNameLabel: UILabel!
    @IBOutlet weak var groopImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
