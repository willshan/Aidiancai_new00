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
    /*
    let path = dataFilePath()
    if let data = try? Data(contentsOf: path){
    loadChecklists(data)
    }
    */
    //test parse JsonData here
    if let url = jsonURL() {
        if let jsonData = loadJsonData(url: url) {
            if let parseData = parse(data: jsonData) {
                self.categories = parseData
                for category in categories {
                    let res = category.restaurants
                    for r in res {
                        let ms = r.menuList
                        for m in ms {
                            let dishlist = m.dishList
                            for dish in dishlist {
                                print(dish.dishName)
                            }
                        }
                    }
                }
            }
        }
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

//load data by URL
extension DataModel {
    func jsonURL() -> URL? {
        let bundle = Bundle.main
        if let path = bundle.path(forResource: "aLaCarte", ofType: "json") {
            let url = URL.init(fileURLWithPath: path)
            print("get jsonURL successfully \(url)")
            return url
        } else {
            print("get jsonURL error")
            return nil
        }
    }
    
    func loadJsonData(url : URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        }catch {
            print("get jsonData error")
            return nil
        }
    }
    
    func parse(data : Data) -> [Category]? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Categories.self, from: data)
            return result.categories
        }catch {
            print("parse error")
            return nil
        }
    }
}
