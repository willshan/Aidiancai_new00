//
//  CategoryTableViewController.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/1.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {

    var dataModel: DataModel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.categories.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = dataModel.categories[indexPath.row]
      
        configureNameLabel(for:categoryCell, with:category)
        configureImage(for:categoryCell, with:category)
      
      /*网上找到的设定图片圆角的方法，与在storyboard里的涉及的方法（layer.cornerRadius, layer.masksBounds)不太一样，供日后学习使用。
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = 8
      imageView.layer.shouldRasterize = true
      */
        return categoryCell
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let restaurantListTableViewController = segue.destination as! RestaurantListViewController
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
        restaurantListTableViewController.category = dataModel.categories[indexPath.row]
        restaurantListTableViewController.dishes = dataModel.dishes //fake data
      }
    }

  // MARK: - 辅助函数
    func configureNameLabel(for cell:UITableViewCell, with category:Category){
        let label = cell.viewWithTag(1010) as! UILabel
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 3.0;
        shadow.shadowOffset = CGSize(width: -5.0, height: 5.0)
        shadow.shadowColor = UIColor.black
        let attributedText = NSAttributedString(string: category.name, attributes: [NSAttributedStringKey.shadow : shadow])
        label.attributedText = attributedText
        //label.text = category.name
    }

    func configureImage(for cell:UITableViewCell, with category:Category){
      let imageView = cell.viewWithTag(1000) as! UIImageView
      let index = dataModel.categories.index(of: category)
      
      if let imagePath = category.imagePath, let data = try? Data(contentsOf: imagePath) {
        imageView.image = UIImage(data: data)
      }else if index == 0 {
        imageView.image = UIImage(named: "categoryBreakfast")
      }else if index == 1 {
        imageView.image = UIImage(named: "categoryLunch")
      }else if index == 2 {
        imageView.image = UIImage(named: "categorySnack")
      }
    }

}
