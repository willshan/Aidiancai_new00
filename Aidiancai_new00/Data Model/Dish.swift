//
//  Dish.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/9/12.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import Foundation

class Dish: NSObject {
  let dishID = DishID()
  var dishName = ""
  weak var menuID:MenuID?
}