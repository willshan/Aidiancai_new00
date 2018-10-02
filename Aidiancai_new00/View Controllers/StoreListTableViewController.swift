//
//  StoreListTableViewController.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/2.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

class StoreListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreListCell", for: indexPath)
      let storeNameLabel = cell.viewWithTag(2101) as! UILabel
      let cuisineLabel = cell.viewWithTag(2102) as! UILabel
      let scoreLabel = cell.viewWithTag(2103) as! UILabel
      
      let starImage1 = cell.viewWithTag(2201) as! UIImageView
      let starImage2 = cell.viewWithTag(2202) as! UIImageView
      let starImage3 = cell.viewWithTag(2203) as! UIImageView
      let starImage4 = cell.viewWithTag(2204) as! UIImageView
      let starImage5 = cell.viewWithTag(2205) as! UIImageView

      let logoImage = cell.viewWithTag(2300) as! UIImageView

      if indexPath.row == 0 {
      storeNameLabel.text = "东来顺"
      cuisineLabel.text = "北京清真涮羊肉"
      scoreLabel.text = "200 reviews"
        
      starImage1.image = UIImage(named: "GreenStar")
      starImage2.image = UIImage(named: "GreenStar")
      starImage3.image = UIImage(named: "GreenStar")
      starImage4.image = UIImage(named: "GreenStar")
      starImage5.image = UIImage(named: "GrayStar")
        
      logoImage.image = UIImage(named: "storeNameDonglaishun")
        
      } else if indexPath.row == 1 {
        storeNameLabel.text = "全聚德-王府井店"
        cuisineLabel.text = "北京烤鸭"
        scoreLabel.text = "5035 reviews"
        
        starImage1.image = UIImage(named: "GreenStar")
        starImage2.image = UIImage(named: "GreenStar")
        starImage3.image = UIImage(named: "GreenStar")
        starImage4.image = UIImage(named: "GreenStar")
        starImage5.image = UIImage(named: "GrayStar")
        
        logoImage.image = UIImage(named: "storeNameQuanjude")
        
      }else if indexPath.row == 2 {
        storeNameLabel.text = "白记水饺"
        cuisineLabel.text = "水饺"
        scoreLabel.text = "6975 reviews"
        
        starImage1.image = UIImage(named: "GreenStar")
        starImage2.image = UIImage(named: "GreenStar")
        starImage3.image = UIImage(named: "GreenStar")
        starImage4.image = UIImage(named: "GrayStar")
        starImage5.image = UIImage(named: "GrayStar")
        
        logoImage.image = UIImage(named: "storeNameBaiji")
        
      }else if indexPath.row == 3 {
        storeNameLabel.text = "桂顺斋"
        cuisineLabel.text = "天津糕点"
        scoreLabel.text = "59865 reviews"
        
        starImage1.image = UIImage(named: "GreenStar")
        starImage2.image = UIImage(named: "GreenStar")
        starImage3.image = UIImage(named: "GreenStar")
        starImage4.image = UIImage(named: "GreenStar")
        starImage5.image = UIImage(named: "GreenStar")
        
        logoImage.image = UIImage(named: "storeNameGuishunzhai")
        
      }else if indexPath.row == 4 {
        storeNameLabel.text = "得月楼"
        cuisineLabel.text = "苏帮菜"
        scoreLabel.text = "56 reviews"
        
        starImage1.image = UIImage(named: "GreenStar")
        starImage2.image = UIImage(named: "GreenStar")
        starImage3.image = UIImage(named: "GrayStar")
        starImage4.image = UIImage(named: "GrayStar")
        starImage5.image = UIImage(named: "GrayStar")
        
        logoImage.image = UIImage(named: "storeNameDeyuelou")
        
      }
        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
