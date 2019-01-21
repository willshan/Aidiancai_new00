//
//  OrderCell.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/1/20.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
