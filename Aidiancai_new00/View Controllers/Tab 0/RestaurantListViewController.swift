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
    var dishes: [Dish]! //fake var
    var orderTemp: OrderTemp! //Injection var
    
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
        let restaurantViewController = segue.destination as! RestaurantDetailViewController
        if let index = tableView.indexPath(for: sender as! UITableViewCell){
            let restaurant = category.restaurants[index.row]
            
            restaurantViewController.dishes = dishes
            restaurantViewController.restaurant = restaurant
            restaurantViewController.mealCatagory = category.name
            restaurantViewController.orderTemp = orderTemp
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
      reviewsLabel.text = "\(restaurant.reviews) 人评价"
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
        logo.image = UIImage(named: RestaurantsExample.donglaishun)
      }else if indexOfRestaurant == 1 {
        logo.image = UIImage(named: RestaurantsExample.quanjude)
      }else if indexOfRestaurant == 2 {
        logo.image = UIImage(named: RestaurantsExample.baijishuijiao)
      }else if indexOfRestaurant == 3 {
        logo.image = UIImage(named: RestaurantsExample.guishunzhai)
      }else if indexOfRestaurant == 4 {
        logo.image = UIImage(named: RestaurantsExample.deyuelou)
      }
    }

}
