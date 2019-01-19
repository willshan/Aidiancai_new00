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
      let store1 = Restaurant()
      store1.name = "东来顺"
      store1.cuisine = "北京清真涮羊肉"
      store1.reviews = 200
      store1.favorableRate = 4
      category2.stores.append(store1)
    
      let store2 = Restaurant()
      store2.name = "全聚德"
      store2.cuisine = "北京烤鸭"
      store2.reviews = 2500
      store2.favorableRate = 4
      category2.stores.append(store2)
      
      let store3 = Restaurant()
      store3.name = "白记水饺"
      store3.cuisine = "水饺"
      store3.reviews = 2689
      store3.favorableRate = 3
      category2.stores.append(store3)
      
      let store4 = Restaurant()
      store4.name = "桂顺斋"
      store4.cuisine = "天津糕点"
      store4.reviews = 896586
      store4.favorableRate = 5
      category2.stores.append(store4)
      
      let store5 = Restaurant()
      store5.name = "得月楼"
      store5.cuisine = "苏帮菜"
      store5.reviews = 986
      store5.favorableRate = 2
      category2.stores.append(store5)
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
