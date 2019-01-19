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
    //dishTemp are dishes and related information, such as count, to be deliverred to confirmDishVC
//    var dishTemp = [DishTemp]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置tableView至Segmented controller下方
        dishesTableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
        title = "安排"+mealCatagory+".\(restaurant.name)"
        
        //check the restaurant is orderred, if yes load order, if no clear old order and creat new empty
        guard OrderTemp.share.restaurantID == restaurant.restaurantID.value.uuidString else {
            OrderTemp.share.restaurantID = restaurant.restaurantID.value.uuidString
            OrderTemp.share.removeAll()
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController = segue.destination as! ConfirmDishListViewController
        //add slectedDishID into dishTemp
//        dishTemp.removeAll() //clear dishTemp first
//        let slectedDishID = OrderTemp.share.dishIDinOrder
//        for dishID in slectedDishID {
//            for dish in dishes {
//                if dishID.value == dish.dishID.value.uuidString {
//                    dishTemp.append(DishTemp(dish: dish))
//                    break
//                }
//            }
//        }
//        print("\(dishTemp)")
        let dishDic = OrderTemp.share.dishInOrder
        var dishTemp = [DishTemp]()
        for dish in dishDic {
            dishTemp.append(dish.value)
        }
        viewController.dishTemp = dishTemp
        viewController.restaurant = restaurant
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
        let orderedDishDic = OrderTemp.share.dishInOrder
        cell.add.isSelected = false
        cell.add.setImage(UIImage(named: AssetsName.addIcon), for: .normal)
        cell.add.setImage(UIImage(named: AssetsName.checkIcon), for: .selected)
        for orderedDish in orderedDishDic {
            print("\(orderedDish.key) vs \(dish.dishID.value.uuidString)")
            if orderedDish.key == dish.dishID.value.uuidString {
                cell.add.isSelected = true
                break
            }
        }
        
        //set up add button func
        cell.add.addTarget(self, action: #selector(addOrRemoveDishes(_:)), for: .touchUpInside)
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
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
            OrderTemp.share.addDishTemp(dish: DishTemp(dish: dish!))
        }
        else {
            sender.isSelected = false
            //remove dishTemp from OrderTemp
            let cell = sender.superview?.superview?.superview as! DishCell
            let dish = getDishFromCell(cell: cell)
            OrderTemp.share.removeDishTemp(dishID: (dish?.dishID.value.uuidString)!)
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

