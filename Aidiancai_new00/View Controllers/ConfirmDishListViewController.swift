//
//  ConfirmDishListViewController.swift
//  Aidiancai_new00
//
//  Created by Admin on 2018/12/21.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit
//该VC的导航栏可选择午餐/晚餐
//冷菜，热菜，饮料由按钮变为标签格式，
//开始时commentTextFiled隐藏，点击备注按钮后，commentTextField出现，keyboard出现并上移，开始输入，发送后继续隐藏

class ConfirmDishListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var dateSelectionButton: UIButton!
    @IBOutlet weak var timeSelectionButton: UIButton!
    @IBOutlet weak var confirmOrderButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var personsLabel: UILabel!
    @IBOutlet weak var commentTextFiled: UITextField!
    @IBOutlet weak var commentSuperView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var colddishCountLabel: UILabel!
    @IBOutlet weak var hotdishCountLabel: UILabel!
    @IBOutlet weak var drinkCountLabel: UILabel!
    
    @IBAction func peoplePlus(_ sender: UIButton) {
        peopleCount += 1
    }
    
    @IBAction func peopleMinus(_ sender: UIButton) {
        peopleCount -= 1
    }
    
    var coldCount = 0 {
        didSet{
            self.colddishCountLabel.text = "\(coldCount)份"
        }
    }
    var hotCount = 0 {
        didSet{
            self.hotdishCountLabel.text = "\(hotCount)份"
        }
    }
    var drinkCount : Int = 0 {
        didSet{
            self.drinkCountLabel.text = "\(drinkCount)份"
        }
    }
    var peopleCount : Int = 3 {
        didSet{
            self.personsLabel.text = "\(peopleCount)人"
        }
    }
    
    var mealCategory: String!
    var dishTemp : [DishTemp]!
    var store : Restaurant!
    var commentEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmOrderButton.isEnabled = false
        
        if mealCategory == nil {
            mealCategory = "晚餐"
        }
        
        var commentButtonItem : UIBarButtonItem {
            return UIBarButtonItem(title: "备注", style: .plain, target: self, action: nil)
        }
        
        navigationItem.rightBarButtonItem = commentButtonItem
        navigationItem.title = store.name
        
        commentSuperView.layer.borderWidth = 0.5
        commentSuperView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        commentSuperView.isHidden = true

        // Do any additional setup after loading the view.
        setupDishesCount()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view appear in confirm vc")
    }
    override func viewDidLayoutSubviews() {
        setupView1View2()
    }
}

extension ConfirmDishListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishTemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.confirmCell, for: indexPath) as! ConfirmCell
        
        let dish = dishTemp[indexPath.row]
        
        if dish.dish.dishPics.count != 0{
            cell.photo.image = UIImage(named: dish.dish.dishPics.first!)
        }
        cell.name.text = dish.dish.dishName
        cell.countLabel.text = String(dish.dishCount)
        cell.countMinus?.addTarget(self, action: #selector(minusCount(_:)), for: .touchUpInside)
        cell.countPlus?.addTarget(self, action: #selector(plusCount(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func minusCount(_ sender : UIButton) {
        let contentView = sender.superview?.superview
        let cell = contentView?.superview as! ConfirmCell
        
        //这是一个非常牛逼的方法，用来找到cell的TableView
        func superTableView() -> UITableView? {
            for view in sequence(first: cell.superview, next: { $0?.superview }) {
                if let tableView = view as? UITableView {
                    return tableView
                }
            }
            return nil
        }
        
        let tableView = superTableView()
        let index = tableView?.indexPath(for: cell)!
        
        dishTemp[index!.row].dishCount -= 1
        
        switch dishTemp[index!.row].dish.dishType {
        case "冷菜":
            coldCount -= 1
        case "热菜":
            hotCount -= 1
        case "饮料":
            drinkCount -= 1
        default:
            break
        }
        cell.countLabel.text = String(dishTemp[index!.row].dishCount)
    }
    
    @objc func plusCount(_ sender : UIButton) {
    }
}

extension ConfirmDishListViewController {
    func setupView1View2() {
        //设置切哪个直角
        //    UIRectCornerTopLeft     = 1 << 0,  左上角
        //    UIRectCornerTopRight    = 1 << 1,  右上角
        //    UIRectCornerBottomLeft  = 1 << 2,  左下角
        //    UIRectCornerBottomRight = 1 << 3,  右下角
        //    UIRectCornerAllCorners  = ~0UL     全部角
        //view1 得到view的mask path
        let maskPath1 = UIBezierPath(roundedRect: view1.bounds, byRoundingCorners: UIRectCorner.topLeft, cornerRadii: CGSize(width: 20, height: 20))
        //创建 layer
        let maskLayer1 = CAShapeLayer.init()
        maskLayer1.frame = view1.bounds
        //赋值
        maskLayer1.path = maskPath1.cgPath
        view1.layer.mask = maskLayer1
        
        //view2
        let maskPath2 = UIBezierPath(roundedRect: view2.bounds, byRoundingCorners: UIRectCorner.topRight, cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer2 = CAShapeLayer.init()
        maskLayer2.frame = view2.bounds
        maskLayer2.path = maskPath2.cgPath
        view2.layer.mask = maskLayer2
    }
    
    func setupDishesCount() {
        for meal in dishTemp {
            switch meal.dish.dishType {
            case "冷菜":
                coldCount += 1
            case "热菜":
                hotCount += 1
            case "饮料":
                drinkCount += 1
            default:
                continue
            }
        }
        self.colddishCountLabel.text = "\(coldCount)份"
        self.hotdishCountLabel.text = "\(hotCount)份"
        self.drinkCountLabel.text = "\(drinkCount)份"
    }
}

extension ConfirmDishListViewController {
    func updateOrderBT() {
        if dishTemp.count == 0 || timeSelectionButton.titleLabel?.text == "选择时间" {
            self.confirmOrderButton.isEnabled = false
            self.confirmOrderButton.backgroundColor = UIColor.lightGray
        }
        else {
            self.confirmOrderButton.isEnabled = true
            self.confirmOrderButton.backgroundColor = UIColor.blue
        }
    }
}
