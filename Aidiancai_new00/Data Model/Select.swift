//
//  Select.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/1/19.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import Foundation

final class Select {
    
    static let share = Select()
    
    var selectedDishID = [String : String]()
    //init from local disk
    
    private init() {} // Prevent clients from creating another instance.
    
    //add DishID
    func addDishID(dishID : String) {
        selectedDishID[dishID] = dishID
    }
    
    //remove DishID
    func removeDishID(dishID : String) {
        selectedDishID.removeValue(forKey: dishID)
    }
    
    //remove all
    func removeAll() {
        selectedDishID.removeAll()
    }
}
