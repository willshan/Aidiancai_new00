//
//  Menu.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/9/12.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import Foundation
class Menu:NSObject {
  let menuID = MenuID()
  var menuName = ""
  var dishList = [DishID]()
  weak var restaurantID: RestaurantID?
}
