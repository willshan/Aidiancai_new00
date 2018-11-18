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
    
    var dishs : [Dish]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension DishListViewController : UITableViewDataSource, UITableViewDelegate {
    // MARK: - Methods of Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.dishCell, for: indexPath) as! DishCell
        let dish = dishs[indexPath.row]
        
        cell.name.text = dish.dishName
        if dish.dishPics.count != 0{
            cell.dishPic.image = UIImage(named: dish.dishPics.first!)
        }
        
        return cell
    }
    
    // MARK: - Methods of Table View Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
