//
//  StoreListTableViewController.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/2.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class StoreListTableViewController: UITableViewController {

    var stores = [Restaurant]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var store = Restaurant()
        store.name = "东来顺"
        store.cuisine = "北京清真涮羊肉"
        store.reviews = 200
        store.favorableRate = 4
        stores.append(store)
      
        store = Restaurant()
        store.name = "全聚德"
        store.cuisine = "北京烤鸭"
        store.reviews = 2500
        store.favorableRate = 4
        stores.append(store)
      
        store = Restaurant()
        store.name = "白记水饺"
        store.cuisine = "水饺"
        store.reviews = 2689
        store.favorableRate = 3
        stores.append(store)
      
        store = Restaurant()
        store.name = "桂顺斋"
        store.cuisine = "天津糕点"
        store.reviews = 896586
        store.favorableRate = 5
        stores.append(store)
      
        store = Restaurant()
        store.name = "得月楼"
        store.cuisine = "苏帮菜"
        store.reviews = 986
        store.favorableRate = 2
        stores.append(store)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreListCell", for: indexPath)
        let store = stores[indexPath.row]
        configureStoreInformation(for: cell, with: store)
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }

  // MARK: - 辅助函数
    func configureStoreInformation(for cell:UITableViewCell, with store:Restaurant){
      configureName(for:cell, with:store)
      configureCuisine(for:cell, with:store)
      configureFavorableRate(for:cell, with:store)
      configureLogo(for:cell, with:store)
    }
  
    func configureName(for cell:UITableViewCell, with store:Restaurant) {
      let storeNameLabel = cell.viewWithTag(2101) as! UILabel
      storeNameLabel.text = store.name
    }

    func configureCuisine(for cell:UITableViewCell, with store:Restaurant){
      let cuisineLabel = cell.viewWithTag(2102) as! UILabel
      cuisineLabel.text = store.cuisine
    }
  
    func configureFavorableRate(for cell:UITableViewCell, with store:Restaurant){
      let reviewsLabel = cell.viewWithTag(2103) as! UILabel
      reviewsLabel.text = "\(store.reviews) reviews"
      //设置星星
      for i in 1...store.favorableRate {
        let starImage = cell.viewWithTag(2200+i) as! UIImageView
        starImage.image = UIImage(named: "GreenStar")
      }
      if store.favorableRate < 5 {
        for i in (store.favorableRate+1)...5{
          let starImage = cell.viewWithTag(2200+i) as! UIImageView
          starImage.image = UIImage(named: "GrayStar")
        }
      }
    }
  
    func configureLogo(for cell:UITableViewCell, with store:Restaurant){
      let logo = cell.viewWithTag(2300) as! UIImageView
      let indexOfStore = stores.index(of: store)
      if let logoAddress = store.logoAddress {
        if let logoImageData = try? Data(contentsOf: logoAddress){
          logo.image = UIImage(data: logoImageData)
        }
      }else if indexOfStore == 0 {
        logo.image = UIImage(named: "storeNameDonglaishun")
      }else if indexOfStore == 1 {
        logo.image = UIImage(named: "storeNameQuanjude")
      }else if indexOfStore == 2 {
        logo.image = UIImage(named: "storeNameBaiji")
      }else if indexOfStore == 3 {
        logo.image = UIImage(named: "storeNameGuishunzhai")
      }else if indexOfStore == 4 {
        logo.image = UIImage(named: "storeNameDeyuelou")
      }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
