//
//  MenuList.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/3/13.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import Foundation
class MenuList: Codable {
    var menuID = MenuID().value.uuidString
    var menuName = ""
    var dishList = [Dish]()
}
