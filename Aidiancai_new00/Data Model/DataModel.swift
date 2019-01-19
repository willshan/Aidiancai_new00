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
  
  init() {
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
