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
    //dishs are dishs in specified store
    var dishs : [Dish]!
    var store : Restaurant!
    var mealCatagory : String!
    //dishTemp are dishs and related information, such as count, to be deliverred to confirmDishVC
    var dishTemp = [DishTemp]()

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //fake code
        let viewController = segue.destination as! ConfirmDishListViewController
        
        for dish in dishs {
            dishTemp.append(DishTemp(dish: dish))
        }
        viewController.dishTemp = dishTemp
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
        
        //set up dish's proporty favorite
        let favoriteDishID = Favorite.share.favoriteDishID
        
        cell.favorite.isHidden = true
        
        for dishID in favoriteDishID {
            if dishID.key == dish.dishID.value.uuidString {
                cell.favorite.isHidden = false
                break
            }
        }
        //set up add button func
        cell.add.addTarget(self, action: #selector(addOrRemoveDishs(_:)), for: .touchUpInside)
//        cell.order?.isSelected = meal.cellSelected
//        cell.order?.setTitle("加入菜单", for: .normal)
//        cell.order?.setTitle("已加入", for: .selected)
//        cell.order?.addTarget(self, action: #selector(addToShoppingCart(_:)), for: .touchUpInside)
        
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
    //add or remove dishs to or from dishTemp
    @objc func addOrRemoveDishs(_ sender : UIButton) {
        print("add button tapped")
        if sender.isSelected == false {
            sender.isSelected = true
            sender.setImage(UIImage(named: AssetsName.checkIcon), for: .selected)
        }
        else {
            sender.isSelected = false
            sender.setImage(UIImage(named: AssetsName.addIcon), for: .normal  )
        }
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

