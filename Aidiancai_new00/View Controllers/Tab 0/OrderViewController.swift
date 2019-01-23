//
//  OrderViewController.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/1/20.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBAction func pay(_ sender: UIButton) {
        
    }
    
    var mealCategory: String!
    var dishesTemp : [DishTemp]!
    var restaurant : Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewHeight()
    }
}
extension OrderViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishesTemp.count + 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != dishesTemp.count {
            return 44
        }
        else {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < dishesTemp.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.orderCell, for: indexPath) as! OrderCell
            
            let dish = dishesTemp[indexPath.row]
            cell.number.text = String(indexPath.row+1)
            cell.name.text = dish.dish.dishName
            cell.time.text = OrderViewController.timeConvertString(date: Date())
            cell.count.text = String(dish.dishCount)+"份"
            cell.comment.text = dish.comment
            cell.cost.text = "￥25"
            
            return cell
        }
        if indexPath.row == dishesTemp.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.orderCell01, for: indexPath)
            let commentTextView = cell.viewWithTag(3000) as! UITextView
            if OrderTemp.share.comment == "" {
                commentTextView.text = "这是一个很长很长的测试文字，有多长呢，我也不知道，但是这不重要，因为它只是用来测试的，真的，程序从来不会说谎！你不信，反正我信了。"
            }
            else {
                commentTextView.text = OrderTemp.share.comment
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.orderCell02, for: indexPath)
            let label = cell.viewWithTag(3010) as! UILabel
            let cost = cell.viewWithTag(3020) as! UILabel
            switch indexPath.row {
            case dishesTemp.count+1 :
                label.text = "菜价小计"
                label.textColor = UIColor.lightGray
                cost.text = "￥3200"
            case dishesTemp.count+2 :
                label.text = "包间费"
                label.textColor = UIColor.lightGray
                cost.text = "￥800"
            case dishesTemp.count+3 :
                label.text = "总价"
                label.font = UIFont.boldSystemFont(ofSize: 20)
                cost.text = "￥4000"
                cost.font = UIFont.boldSystemFont(ofSize: 20)
            default:
                label.text = "error"
                cost.text = "error"
            }
            return cell
        }
    }
}

extension OrderViewController {
    static func timeConvertString(date:Date) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm YYYY-MM-dd"//设置时间格式；hh——>12小时制， HH———>24小时制
        
        let date = formatter.string(from: date)
        print("\(date) and \(date.components(separatedBy: " ").first!)")
        return date.components(separatedBy: " ").first!
    }
    func setupTableViewHeight() {
        let height = CGFloat((dishesTemp.count+3)*44+90)
        let screenAvailableHeight = UIScreen.main.bounds.height-140
        if height > screenAvailableHeight {
            tableViewHeight.constant = screenAvailableHeight
        }
        else {
            tableViewHeight.constant = height
        }
    }
}
