//
//  Restaurant.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/9/12.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit
class Restaurant:NSObject, Codable {
    let restaurantID = RestaurantID()
    var name = ""
    var cuisine = ""
    var favorableRate = 3
    var reviews = 100
    var logoAddress:URL?
    var menuList = [MenuID]()
    var introduction = ""
}
