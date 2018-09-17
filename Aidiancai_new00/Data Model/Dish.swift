//
//  Dish.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/9/12.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class Dish: NSObject, Codable { //作为NSObject的子类目的是为了可以在Dish数组中使用index(of:)方法P312和存取相关方法P313
  let dishID = DishID()
  weak var menuID:MenuID?
  var dishName = ""
  var dishPics = [String]()//图片名字的数组
}
