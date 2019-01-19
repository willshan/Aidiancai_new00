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
    var restaurant : Restaurant!
    var commentEditing = false
    var indexTemp = IndexPath() //to record cell index temporary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register notification center
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillChange(_:)),
                                               name: .UIKeyboardWillChangeFrame, object: nil)

        if mealCategory == nil {
            mealCategory = "晚餐"
        }
        
        var commentButtonItem : UIBarButtonItem {
            return UIBarButtonItem(title: "备注", style: .plain, target: self, action: nil)
        }
        
        navigationItem.rightBarButtonItem = commentButtonItem
        navigationItem.title = restaurant.name
        
        commentSuperView.layer.borderWidth = 0.5
        commentSuperView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        commentSuperView.isHidden = true

        // Do any additional setup after loading the view.
        updateCountForDishLabel()
        updateConfirmButton()
        
        //set up delegate
        commentTextFiled.delegate = self
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
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        cell.commentLabel.text = dish.comment
        
        if cell.commentLabel.text == "" {
            cell.tintColor = UIColor.lightGray
        }
        else {
            cell.tintColor = UIColor.blue
        }
        
        cell.countLabel.text = String(dish.dishCount)
        cell.countMinus?.addTarget(self, action: #selector(minusCount(_:)), for: .touchUpInside)
        cell.countPlus?.addTarget(self, action: #selector(plusCount(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if commentSuperView.isHidden == false {
            commentSuperView.isHidden = true
            commentTextFiled.resignFirstResponder() //hide keyboard
        }
        else {
            commentSuperView.isHidden = false
            commentTextFiled.becomeFirstResponder() //awake keyboard
            self.indexTemp = indexPath
            commentTextFiled.text = dishTemp[indexPath.row].comment
        }
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
    
    @objc func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            //self.view.setNeedsLayout()
            //改变上约束
            self.bottomConstraint.constant = intersection.height
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve), animations: {
                            
                            self.view.layoutIfNeeded()
                            
            }, completion: nil)
        }
    }
}

extension ConfirmDishListViewController {
    @objc func minusCount(_ sender : UIButton) {
        updateDishCount(sender: sender, plus: false)
    }
    
    @objc func plusCount(_ sender : UIButton) {
        updateDishCount(sender: sender, plus: true)
    }
    
    //update count for specified dish
    func updateDishCount(sender : UIButton, plus : Bool) {
        let index = getDishIndex(sender: sender)
        if plus == true {
            dishTemp[index!.row].dishCount += 1
        }
        else {
            dishTemp[index!.row].dishCount -= 1
        }
        let cell = tableView.cellForRow(at: index!) as! ConfirmCell
        cell.countLabel.text = String(dishTemp[index!.row].dishCount)
        updateCountForDishLabel()
    }
    
    //update total count
    func updateCountForDishLabel() {
        coldCount = 0
        hotCount = 0
        drinkCount = 0
        for dish in dishTemp {
            switch dish.dish.dishType {
            case "冷菜":
                coldCount += dish.dishCount
            case "热菜":
                hotCount += dish.dishCount
            case "饮料":
                drinkCount += dish.dishCount
            default:
                continue
            }
        }
    }
    
    //get indexPath of specified button(plus or minus button)
    func getDishIndex(sender : UIButton) -> IndexPath? {
        
        let contentView = sender.superview?.superview
        let cell = contentView?.superview as! ConfirmCell
        
        //find the tableView of specified cell
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
        return index
    }

    func updateConfirmButton() {
        if dishTemp.count == 0 {
            confirmOrderButton.isEnabled = false
            confirmOrderButton.backgroundColor = UIColor.lightGray
        }
        else {
            confirmOrderButton.isEnabled = true
            confirmOrderButton.backgroundColor = UIColor.blue
        }
    }
}

extension ConfirmDishListViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        print("\(commentEditing)")
        textField.resignFirstResponder()
        commentSuperView.isHidden = true
        self.dishTemp[indexTemp.row].comment = commentTextFiled.text!
        self.tableView.reloadData()
        return true
    }
}
