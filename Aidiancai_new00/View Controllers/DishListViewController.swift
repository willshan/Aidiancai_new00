//
//  StoreViewController.swift
//  Aidiancai_new00
//
//  Created by Admin on 2018/11/12.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class DishListViewController: UIViewController {
    
    @IBOutlet weak var dishsTableView: UITableView!
    @IBOutlet weak var dishCatagory: UISegmentedControl!
    @IBAction func dishCatagoryChanged(_ sender: Any) {
        dishsTableView.reloadData()
    }
    
    var dishs : [Dish]!
    var store : Restaurant!
    var mealCatagory : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置tableView至Segmented controller下方
        dishsTableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
        title = "安排"+mealCatagory+".\(store.name)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let viewController = segue.destination as! ConfirmDishListViewController
        viewController.dishs = dishs
        viewController.store = store
    }
}

extension DishListViewController : UITableViewDataSource, UITableViewDelegate {
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDishsInCatagory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.dishCell, for: indexPath) as! DishCell

        let dishsInCatagory = getDishsInCatagory()
        
        let dish = dishsInCatagory[indexPath.row]
        
        cell.name.text = dish.dishName
        if dish.dishPics.count != 0{
            cell.dishPic.image = UIImage(named: dish.dishPics.first!)
        }
        
        let favoriteDishID = Favorite.share.favoriteDishID
        
        cell.favorite.isHidden = true
        
        for dishID in favoriteDishID {
            if dishID.key == dish.dishID.value.uuidString {
                cell.favorite.isHidden = false
                break
            }
        }
        
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
    //将dish从不同的菜类中区分出来，并返回对应的数组
    func getDishsInCatagory()-> [Dish] {
        let kind: String
        var count = 0
        var dishsInCatagory = [Dish]()
        
        switch dishCatagory.selectedSegmentIndex {
        case 1: kind = "冷菜"
        case 2: kind = "热菜"
        case 3: kind = "饮料"
        default: kind = ""
        }
        if kind == "" {
            count = dishs.count
            dishsInCatagory = dishs
        }
        else {
            for dish in dishs {
                if dish.dishType == kind {
                    count += 1
                    dishsInCatagory.append(dish)
                }
            }
        }
        return dishsInCatagory
    }
}

