//
//  DishCell.swift
//  Aidiancai_new00
//
//  Created by Admin on 2018/11/12.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class DishCell: UITableViewCell {

    @IBOutlet weak var dishPic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var favorite: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var reviews: Reviews!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
