//
//  Category.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/5.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class Category: NSObject, Codable {
    var name = ""
    var imagePath = ""
    var restaurants = [Restaurant]()
    
    init(name:String){
        self.name = name
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "categoryName"
        case imagePath
        case restaurants
    }
}
