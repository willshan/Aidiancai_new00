//
//  Favorite.swift
//  Aidiancai_new00
//
//  Created by Admin on 2018/11/21.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import Foundation

final class Favorite {
    
    static let share = Favorite()

    var favoriteDishID = [String : String]()
    //init from local disk
    
    private init() {} // Prevent clients from creating another instance.
    
    //add favoriteDishID
    func addFavoriteDishID(dishID : String) {
        favoriteDishID[dishID] = dishID
    }
    
    //delete favoriteDishID
    func removeFavoriteDishID(dishID : String) {
        favoriteDishID.removeValue(forKey: dishID)
    }
    
    //remove all
    func removeAll() {
        favoriteDishID.removeAll()
    }
}
