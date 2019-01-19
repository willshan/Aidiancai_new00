//
//  RestaurantListViewController.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/2.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class RestaurantListViewController: UITableViewController {
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
        let restaurantViewController = segue.destination as! DishListViewController
        if let index = tableView.indexPath(for: sender as! UITableViewCell){
            var dishes = [Dish]()
            let restaurant = category.restaurants[index.row]
            
            //fake code
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
            //fake code
//            Select.share.removeAll()
//            Select.share.addDishID(dishID: (dish1?.dishID.value.uuidString)!)
            
            restaurantViewController.dishes = dishes
            restaurantViewController.restaurant = restaurant
            restaurantViewController.mealCatagory = category.name
        }
    }
  
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category.restaurants.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.restaurantListCell, for: indexPath)
        let restaurant = category.restaurants[indexPath.row]
        configureRestaurantInformation(for: cell, with: restaurant)
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }

  // MARK: - 辅助函数
    func configureRestaurantInformation(for cell:UITableViewCell, with restaurant:Restaurant){
      configureName(for:cell, with:restaurant)
      configureCuisine(for:cell, with:restaurant)
      configureFavorableRate(for:cell, with:restaurant)
      configureLogo(for:cell, with:restaurant)
    }
  
    func configureName(for cell:UITableViewCell, with restaurant:Restaurant) {
      let restaurantNameLabel = cell.viewWithTag(2101) as! UILabel
      restaurantNameLabel.text = restaurant.name
    }

    func configureCuisine(for cell:UITableViewCell, with restaurant:Restaurant){
      let cuisineLabel = cell.viewWithTag(2102) as! UILabel
      cuisineLabel.text = restaurant.cuisine
    }
  
    func configureFavorableRate(for cell:UITableViewCell, with restaurant:Restaurant){
      let reviewsLabel = cell.viewWithTag(2103) as! UILabel
      reviewsLabel.text = "\(restaurant.reviews) reviews"
      //设置星星
      for i in 1...restaurant.favorableRate {
        let starImage = cell.viewWithTag(2200+i) as! UIImageView
        starImage.image = UIImage(named: "GreenStar")
      }
      if restaurant.favorableRate < 5 {
        for i in (restaurant.favorableRate+1)...5{
          let starImage = cell.viewWithTag(2200+i) as! UIImageView
          starImage.image = UIImage(named: "GrayStar")
        }
      }
    }
  
    func configureLogo(for cell:UITableViewCell, with restaurant:Restaurant){
      let logo = cell.viewWithTag(2300) as! UIImageView
      let indexOfRestaurant = category.restaurants.index(of: restaurant)
      if let logoAddress = restaurant.logoAddress {
        if let logoImageData = try? Data(contentsOf: logoAddress){
          logo.image = UIImage(data: logoImageData)
        }
      }else if indexOfRestaurant == 0 {
        logo.image = UIImage(named: "restaurantNameDonglaishun")
      }else if indexOfRestaurant == 1 {
        logo.image = UIImage(named: "restaurantNameQuanjude")
      }else if indexOfRestaurant == 2 {
        logo.image = UIImage(named: "restaurantNameBaiji")
      }else if indexOfRestaurant == 3 {
        logo.image = UIImage(named: "restaurantNameGuishunzhai")
      }else if indexOfRestaurant == 4 {
        logo.image = UIImage(named: "restaurantNameDeyuelou")
      }
    }

}
