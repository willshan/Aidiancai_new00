//
//  Select.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/1/19.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import Foundation

final class OrderTemp {
    
    static let share = OrderTemp()
    
    var restaurantID : String!
    var comment = ""
    var dishInOrder = [String : DishTemp]()
    //init from local disk
    
    private init() {} // Prevent clients from creating another instance.
    
    //add Dish
    func addDishTemp(dish : DishTemp) {
        let key = dish.dish.dishID.value.uuidString
        dishInOrder[key] = dish
    }
    
    //remove Dish
    func removeDishTemp(dishID : String) {
        dishInOrder.removeValue(forKey: dishID)
    }
    
    //remove all
    func removeAll() {
        dishInOrder.removeAll()
    }
    
    //query Dish
    func isDishSelected(dishID : String)->Bool {
        for dish in dishInOrder {
            if dishID == dish.key {
                return true
            }
            else {
                continue
            }
        }
        return false
    }
}
