//
//  CategoryTableViewController.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/1.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    var categories = [Category]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var newCategory = Category(name: "早餐")
        categories.append(newCategory)
      
        newCategory = Category(name: "正餐")
          var store = Restaurant()
          store.name = "东来顺"
          store.cuisine = "北京清真涮羊肉"
          store.reviews = 200
          store.favorableRate = 4
          newCategory.stores.append(store)
      
          store = Restaurant()
          store.name = "全聚德"
          store.cuisine = "北京烤鸭"
          store.reviews = 2500
          store.favorableRate = 4
          newCategory.stores.append(store)

          store = Restaurant()
          store.name = "白记水饺"
          store.cuisine = "水饺"
          store.reviews = 2689
          store.favorableRate = 3
          newCategory.stores.append(store)

          store = Restaurant()
          store.name = "桂顺斋"
          store.cuisine = "天津糕点"
          store.reviews = 896586
          store.favorableRate = 5
          newCategory.stores.append(store)

          store = Restaurant()
          store.name = "得月楼"
          store.cuisine = "苏帮菜"
          store.reviews = 986
          store.favorableRate = 2
          newCategory.stores.append(store)
        categories.append(newCategory)
      
        newCategory = Category(name: "零食")
        categories.append(newCategory)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
      
        configureNameLabel(for:categoryCell, with:category)
        configureImage(for:categoryCell, with:category)
      
      /*网上找到的设定图片圆角的方法，与在storyboard里的涉及的方法（layer.cornerRadius, layer.masksBounds)不太一样，供日后学习使用。
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = 8
      imageView.layer.shouldRasterize = true
      */
        return categoryCell
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let storeListTableViewController = segue.destination as! StoreListTableViewController
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
        storeListTableViewController.category = categories[indexPath.row]
      }
    }

  // MARK: - 辅助函数
    func configureNameLabel(for cell:UITableViewCell, with category:Category){
        let label = cell.viewWithTag(1010) as! UILabel
        label.text = category.name
    }

    func configureImage(for cell:UITableViewCell, with category:Category){
      let imageView = cell.viewWithTag(1000) as! UIImageView
      let index = categories.index(of: category)
      
      if let imagePath = category.imagePath, let data = try? Data(contentsOf: imagePath) {
        imageView.image = UIImage(data: data)
      }else if index == 0 {
        imageView.image = UIImage(named: "categoryBreakfast")
      }else if index == 1 {
        imageView.image = UIImage(named: "categoryLunch")
      }else if index == 2 {
        imageView.image = UIImage(named: "categorySnack")
      }
    }

}
