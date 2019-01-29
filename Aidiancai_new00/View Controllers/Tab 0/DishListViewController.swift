//
//  DishListViewController.swift
//  Aidiancai_new00
//
//  Created by Admin on 2018/11/12.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class DishListViewController: UIViewController {
    
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var dishCatagory: UISegmentedControl!
    @IBAction func dishCatagoryChanged(_ sender: Any) {
        dishesTableView.reloadData()
    }
    //dishes are dishes in specified restaurant
    var dishes : [Dish]!
    var restaurant : Restaurant!
    var mealCatagory : String!
    var orderTemp: OrderTemp! //Injection var
    
    //dishTemp are dishes and related information, such as count, to be deliverred to confirmDishVC
//    var dishTemp = [DishTemp]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置tableView至Segmented controller下方
        dishesTableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
        title = "安排"+mealCatagory+".\(restaurant.name)"
        
        //check the restaurant is orderred, if yes load order, if no clear old order and creat new empty
        guard orderTemp.restaurantID == restaurant.restaurantID.value.uuidString else {
            orderTemp.restaurantID = restaurant.restaurantID.value.uuidString
            orderTemp.removeAll()
            orderTemp.comment = ""
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dishesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch(segue.identifier ?? "") {
            
        case SegueIdentifier.confirmDishListSegue:
            let viewController = segue.destination as! ConfirmDishListViewController
            let dishDic = orderTemp.dishInOrder //reference type
            var dishesTemp = [DishTemp]() //reference type
            for dish in dishDic {
                dishesTemp.append(dish.value)
            }
            viewController.dishesTemp = dishesTemp
            viewController.restaurant = restaurant
            viewController.orderTemp = orderTemp
            
        case SegueIdentifier.dishDetailSegue:
            let viewController = segue.destination as! DishDetailViewController
            let cell = sender as! DishCell
            let index = dishesTableView.indexPath(for: cell)
            viewController.dish = dishes[(index?.row)!]
            viewController.orderTemp = orderTemp
            viewController.dishes = dishes
            viewController.index = index
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
}

extension DishListViewController : UITableViewDataSource, UITableViewDelegate {
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDishesInCatagory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.dishCell, for: indexPath) as! DishCell

        let dishesInCatagory = getDishesInCatagory()
        
        let dish = dishesInCatagory[indexPath.row]
        
        cell.name.text = dish.dishName
        if dish.dishPics.count != 0{
            cell.dishPic.image = UIImage(named: dish.dishPics.first!)
        }
        cell.reviewsLabel.text = "\(dish.reviews)"+" reviews"
        cell.reviews.reviews = dish.reviews/200+1
        
        //set up dish's proporty favorite
        let favoriteDishID = Favorite.share.favoriteDishID
        cell.favorite.isHidden = true
        for dishID in favoriteDishID {
            if dishID.key == dish.dishID.value.uuidString {
                cell.favorite.isHidden = false
                break
            }
        }
        
        //set up dish's property isSelected
        cell.add.setImage(UIImage(named: AssetsName.addIcon), for: .normal)
        cell.add.setImage(UIImage(named: AssetsName.checkIcon), for: .selected)
        cell.add.isSelected = orderTemp.isDishSelected(dishID: dish.dishID.value.uuidString)

        //set up add button func
        cell.add.addTarget(self, action: #selector(addOrRemoveDishes(_:)), for: .touchUpInside)
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    //这个公式目的是，点击菜品后，再返回菜单时，菜品上没有选中阴影
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DishListViewController {
    //get dishID
    func getDishIDFromCell(cell : UITableViewCell) -> String? {
        //get the tableView which the cell belong to
        for view in sequence(first: cell.superview, next: { $0?.superview }) {
            let dishes = getDishesInCatagory()
            if let tableView = view as? UITableView {
                let index = tableView.indexPath(for: cell)!
                let dishID = dishes[(index.row)].dishID
                return dishID.value.uuidString
            }
        }
        return nil
    }
    
    //get dish
    func getDishFromCell(cell : UITableViewCell) -> Dish? {
        //get the tableView which the cell belong to
        for view in sequence(first: cell.superview, next: { $0?.superview }) {
            let dishes = getDishesInCatagory()
            if let tableView = view as? UITableView {
                let index = tableView.indexPath(for: cell)!
                let dish = dishes[(index.row)]
                return dish
            }
        }
        return nil
    }
    
    //add or remove dishes to or from dishTemp
    @objc func addOrRemoveDishes(_ sender : UIButton) {
        print("add button tapped")
        if sender.isSelected == false {
            sender.isSelected = true
            //add dishTemp to OrderTemp
            let cell = sender.superview?.superview?.superview as! DishCell
            let dish = getDishFromCell(cell: cell)
            orderTemp.addDishTemp(dish: DishTemp(dish: dish!))
        }
        else {
            sender.isSelected = false
            //remove dishTemp from OrderTemp
            let cell = sender.superview?.superview?.superview as! DishCell
            let dish = getDishFromCell(cell: cell)
            orderTemp.removeDishTemp(dishID: (dish?.dishID.value.uuidString)!)
        }
    }
}

extension DishListViewController {
    //将dish从不同的菜类中区分出来，并返回对应的数组
    func getDishesInCatagory()-> [Dish] {
        let kind: String
        var count = 0
        var dishesInCatagory = [Dish]()
        
        switch dishCatagory.selectedSegmentIndex {
        case 1: kind = "冷菜"
        case 2: kind = "热菜"
        case 3: kind = "饮料"
        default: kind = ""
        }
        if kind == "" {
            count = dishes.count
            dishesInCatagory = dishes
        }
        else {
            for dish in dishes {
                if dish.dishType == kind {
                    count += 1
                    dishesInCatagory.append(dish)
                }
            }
        }
        return dishesInCatagory
    }
}

