//
//  CategoryTableViewController.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/1.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let imageView = cell.viewWithTag(1000) as! UIImageView
        let lable = cell.viewWithTag(1010) as! UILabel
      if indexPath.row == 0 {
        imageView.image = UIImage(named: "categoryBreakfast")
        lable.text = " 早餐 "
        }else if indexPath.row == 1 {
        imageView.image = UIImage(named: "categoryLunch")
        lable.text = " 正餐 "
      }else if indexPath.row == 2 {
        imageView.image = UIImage(named: "categorySnack")
        lable.text = " 零食 "
      }
      //imageView.clipsToBounds = true
      //imageView.layer.cornerRadius = 8
      //imageView.layer.shouldRasterize = true

        return cell
    }
  
}
