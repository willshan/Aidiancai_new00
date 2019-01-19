//
//   Configure the view for the selected state     }  ConfirmCell.swift
//  Aidiancai_new00
//
//  Created by Admin on 2018/12/21.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class ConfirmCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var countPlus: UIButton!
    @IBOutlet weak var countMinus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        contentView.layer.cornerRadius = 8
//        contentView.layer.masksToBounds = true
//        shadowView.backgroundColor = UIColor.white
//        
//        shadowView.layer.cornerRadius = 8
//        
//        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
//        shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
//        shadowView.layer.shadowRadius = 8
//        shadowView.layer.shadowOpacity = 0.8
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
