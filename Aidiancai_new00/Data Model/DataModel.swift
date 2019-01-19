//
//  File.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/6.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import Foundation

class DataModel {
  var categories = [Category]()
  var dishes = [Dish]()
  init() {
    //fake dishes
    let dish1 = Dish(name: "南京烤鸭", pics: ["烤鸭"], dishType: "热菜")
    let dish2 = Dish(name: "炸鸡", pics: ["炸鸡"], dishType: "冷菜")
    let dish3 = Dish(name: "百威啤酒", pics: ["啤酒"], dishType: "饮料")
    let dish4 = Dish(name: "炸鸡1", pics: ["炸鸡"], dishType: "冷菜")
    let dish5 = Dish(name: "雪花啤酒", pics: ["啤酒"], dishType: "饮料")
    let dish6 = Dish(name: "炸鸡2", pics: ["炸鸡"], dishType: "冷菜")
    let dish7 = Dish(name: "黑啤酒", pics: ["啤酒"], dishType: "饮料")
    let dish8 = Dish(name: "北京烤鸭", pics: ["烤鸭"], dishType: "热菜")
    let dish9 = Dish(name: "炸鸡3", pics: ["炸鸡"], dishType: "冷菜")
    dishes = [dish1, dish2, dish3, dish4, dish5, dish6,dish7, dish8, dish9,] as! [Dish]
    //fake code
    Favorite.share.removeAll()
    Favorite.share.addFavoriteDishID(dishID: (dish1?.dishID.value.uuidString)!)
    Favorite.share.addFavoriteDishID(dishID: (dish5?.dishID.value.uuidString)!)
    Favorite.share.addFavoriteDishID(dishID: (dish8?.dishID.value.uuidString)!)
    
    //早餐
    let category1 = Category(name: "早餐")
    categories.append(category1)
    
    //正餐
    let category2 = Category(name: "正餐")
      let restaurant1 = Restaurant()
      restaurant1.name = "东来顺"
      restaurant1.cuisine = "北京清真涮羊肉"
      restaurant1.reviews = 200
      restaurant1.favorableRate = 4
      category2.restaurants.append(restaurant1)
    
      let restaurant2 = Restaurant()
      restaurant2.name = "全聚德"
      restaurant2.cuisine = "北京烤鸭"
      restaurant2.reviews = 2500
      restaurant2.favorableRate = 4
      category2.restaurants.append(restaurant2)
      
      let restaurant3 = Restaurant()
      restaurant3.name = "白记水饺"
      restaurant3.cuisine = "水饺"
      restaurant3.reviews = 2689
      restaurant3.favorableRate = 3
      category2.restaurants.append(restaurant3)
      
      let restaurant4 = Restaurant()
      restaurant4.name = "桂顺斋"
      restaurant4.cuisine = "天津糕点"
      restaurant4.reviews = 896586
      restaurant4.favorableRate = 5
      category2.restaurants.append(restaurant4)
      
      let restaurant5 = Restaurant()
      restaurant5.name = "得月楼"
      restaurant5.cuisine = "苏帮菜"
      restaurant5.reviews = 986
      restaurant5.favorableRate = 2
      category2.restaurants.append(restaurant5)
    categories.append(category2)
    
    //零食
    let category3 = Category(name: "零食")
    categories.append(category3)

    let path = dataFilePath()
    if let data = try? Data(contentsOf: path){
    loadChecklists(data)
    }
  }
    
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Aidiancai.plist")
  }
  
  func loadChecklists(_ data: Data) {
      let decoder = PropertyListDecoder()
      do {
        categories = try decoder.decode([Category].self, from: data)
      }catch{
        print("Error decoding categories array!")
      }
  }
}
