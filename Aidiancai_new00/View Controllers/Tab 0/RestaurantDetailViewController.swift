//
//  RestaurantDetailViewController.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/1/30.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmental: UISegmentedControl!
    @IBOutlet weak var restaurantIntro: UITextView!
    @IBOutlet weak var favorableRate: FavorableRate!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func isFavorite(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            Favorite.share.removeFavoriteRestaurantID(restaurantID: restaurant.restaurantID.value.uuidString)
        }
        else {
            sender.isSelected = true
            Favorite.share.addFavoriteRestaurantID(restaurantID: restaurant.restaurantID.value.uuidString)
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmental.selectedSegmentIndex {
        case 1:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let dishListViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardID.dishListViewController) as! DishListViewController
            
            dishListViewController.dishes = dishes
            dishListViewController.restaurant = restaurant
            dishListViewController.mealCatagory = mealCatagory
            dishListViewController.orderTemp = orderTemp
            self.navigationController?.pushViewController(dishListViewController, animated: true)
            
        default:
            return
        }
    }
    
    //dishes are dishes in specified restaurant
    var dishes : [Dish]!
    var restaurant : Restaurant!
    var mealCatagory : String!
    var orderTemp: OrderTemp! //Injection var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) //将navigation bar背景设成空白图片
        self.navigationController?.navigationBar.shadowImage = UIImage() //将navigation bar与view的分界线设成空白图片，不设的话，会有一条线
//        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return pic.frame.height
        case 1:
            return 40
        case 2:
            return 300
        default:
            return 44
        }
    }
}

extension RestaurantDetailViewController {
    func setupViews() {
        favorableRate.favorableRate = restaurant.favorableRate
        reviewsLabel.text = "\(restaurant.reviews)"+"人评价"
        nameLabel.text = restaurant.name
        restaurantIntro.text = restaurant.introduction
        
        favoriteButton.setTitle("已收藏", for: .selected)
        favoriteButton.setTitle("未收藏", for: .normal)
        if Favorite.share.isRestaurantFavorite(restaurantID: restaurant.restaurantID.value.uuidString) {
            favoriteButton.isSelected = true
        }
        else {
            favoriteButton.isSelected = false
        }
        // Remove constraints and turn off Auto Layout
        pic.removeConstraints(pic.constraints)
        pic.translatesAutoresizingMaskIntoConstraints = true
        
        let width = UIScreen.main.bounds.width
        let height = (UIScreen.main.bounds.height - 64)/3
        pic.frame = CGRect(x: 0, y: 0, width: width, height: height)
        pic.image = UIImage(named: restaurant.name)
    }
}
/*
class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmental: UISegmentedControl!
    @IBOutlet weak var restaurantIntro: UITextView!
    @IBOutlet weak var favorableRate: FavorableRate!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func isFavorite(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            Favorite.share.removeFavoriteRestaurantID(restaurantID: restaurant.restaurantID.value.uuidString)
        }
        else {
            sender.isSelected = true
            Favorite.share.addFavoriteRestaurantID(restaurantID: restaurant.restaurantID.value.uuidString)
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmental.selectedSegmentIndex {
        case 1:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let dishListViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardID.dishListViewController) as! DishListViewController
            
            dishListViewController.dishes = dishes
            dishListViewController.restaurant = restaurant
            dishListViewController.mealCatagory = mealCatagory
            dishListViewController.orderTemp = orderTemp
            self.navigationController?.pushViewController(dishListViewController, animated: true)
            
        default:
            return
        }
    }
    
    //dishes are dishes in specified restaurant
    var dishes : [Dish]!
    var restaurant : Restaurant!
    var mealCatagory : String!
    var orderTemp: OrderTemp! //Injection var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segmental.selectedSegmentIndex = 0
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) //将navigation bar背景设成空白图片
        self.navigationController?.navigationBar.shadowImage = UIImage() //将navigation bar与view的分界线设成空白图片，不设的话，会有一条线
//        self.navigationController?.navigationBar.isTranslucent = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
 */

