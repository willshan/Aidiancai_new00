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
    var favoriteRestaurantID = [String : String]()
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
    func removeAllDishID() {
        favoriteDishID.removeAll()
    }
    //query favoriteDishID
    func isDishFavorite(dishID : String)->Bool {
        for dish in favoriteDishID {
            if dishID == dish.key {
                return true
            }
            else {
                continue
            }
        }
        return false
    }
    //add favoriteRestaurantID
    func addFavoriteRestaurantID(restaurantID : String) {
        favoriteRestaurantID[restaurantID] = restaurantID
    }
    
    //delete favoriteRestaurantID
    func removeFavoriteRestaurantID(restaurantID : String) {
        favoriteRestaurantID.removeValue(forKey: restaurantID)
    }
    
    //remove all
    func removeAllRestaurantID() {
        favoriteRestaurantID.removeAll()
    }
    //query favoriteRestaurantID
    func isRestaurantFavorite(restaurantID : String)->Bool {
        for restaurant in favoriteRestaurantID {
            if restaurantID == restaurant.key {
                return true
            }
            else {
                continue
            }
        }
        return false
    }
}
