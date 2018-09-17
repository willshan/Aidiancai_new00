//
//  DishID.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/9/14.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import Foundation
class DishID: Codable { //DishID是Dish的一个property，所以为了可以存取，必须遵守Codable Protocol
  let value = UUID()
}
