//
//  StoreListTableViewController.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/2.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class StoreListViewController: UITableViewController {
    var category: Category!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if category.name == "早餐" {
        title = "早点铺"
      }else {
        title = category.name + "店家"
        
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let storeViewController = segue.destination as! DishListViewController
        if let index = tableView.indexPath(for: sender as! UITableViewCell){
            var dishs = [Dish]()
            let store = category.stores[index.row]
            
            //fake code
            let dish1 = Dish(name: "烤鸭", pics: ["烤鸭"], dishType: "热菜")
            let dish2 = Dish(name: "炸鸡", pics: ["炸鸡"], dishType: "冷菜")
            let dish3 = Dish(name: "啤酒", pics: ["啤酒"], dishType: "饮料")
            
            dishs = [dish1, dish2, dish3,dish1, dish2, dish3,dish1, dish2, dish3,] as! [Dish]
            
            Favorite.share.removeAll()
            Favorite.share.addFavoriteDishID(dishID: (dish1?.dishID.value.uuidString)!)
            
            storeViewController.dishs = dishs
            storeViewController.store = store
            storeViewController.mealCatagory = category.name
        }
    }
  
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category.stores.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.storeListCell, for: indexPath)
        let store = category.stores[indexPath.row]
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
      let indexOfStore = category.stores.index(of: store)
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

}
