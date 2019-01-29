//
//  DishDetailViewController.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/1/22.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import UIKit

class DishDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reviews: Reviews!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var dishIntroduction: UITextView!
    
    @IBAction func lastDish(_ sender: Any) {
        if index.row > 0 {
            self.dish = dishes[index.row-1]
            self.index = IndexPath(row: index.row-1, section: index.section)
            setupTitle()
            setupAddButton()
            setupScrollViewUI()
        }
        else {
            self.dish = dishes.last
            self.index = IndexPath(row: dishes.count-1, section: index.section)
            setupTitle()
            setupAddButton()
            setupScrollViewUI()
        }
    }
    @IBAction func nextDish(_ sender: Any) {
        if index.row < dishes.count-1 {
            self.dish = dishes[index.row+1]
            self.index = IndexPath(row: index.row+1, section: index.section)
            setupTitle()
            setupAddButton()
            setupScrollViewUI()
        }
        else {
            self.dish = dishes.first
            self.index = IndexPath(row: 0, section: index.section)
            setupTitle()
            setupAddButton()
            setupScrollViewUI()
        }
    }
    
    var dish : Dish!
    var orderTemp: OrderTemp! //injection var
    var dishes : [Dish]!
    var index : IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupAddButton()
        setupScrollViewUI()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DishDetailViewController {
    func setupTitle() {
        self.title = dish.dishName
        self.reviewLabel.text = "\(dish.reviews)"+" reviews"
        self.reviews.reviews = dish.reviews/200+1
    }
    
    func setupAddButton() {
        //set up add button func
        addButton.addTarget(self, action: #selector(addOrRemoveDishes(_:)), for: .touchUpInside)
        addButton.setImage(UIImage(named: AssetsName.addIcon), for: .normal)
        addButton.setImage(UIImage(named: AssetsName.checkIcon), for: .selected)
        if orderTemp.isDishSelected(dishID: dish.dishID.value.uuidString) {
            addButton.isSelected = true
        }
        else {
            addButton.isSelected = false
        }
    }
    
    //add or remove dishes to or from dishTemp
    @objc func addOrRemoveDishes(_ sender : UIButton) {
        print("add button tapped")
        if sender.isSelected == false {
            sender.isSelected = true
            //add dishTemp to OrderTemp
            orderTemp.addDishTemp(dish: DishTemp(dish: dish))
        }
        else {
            sender.isSelected = false
            //remove dishTemp from OrderTemp
            orderTemp.removeDishTemp(dishID: dish.dishID.value.uuidString)
        }
    }
}

extension DishDetailViewController : UIScrollViewDelegate {
    
    func setupScrollViewUI() {
        scrollView.delegate = self
        // Remove constraints for scroll view, turn off Auto Layout for scroll view
        scrollView.removeConstraints(scrollView.constraints)
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        
        //set up images to be showed
        var images = [UIImage]()
        let image = UIImage(named: dish.dishName)
        images.append(image!)
        
        let width = UIScreen.main.bounds.width
        let height = (UIScreen.main.bounds.height - 64)/3
        scrollView.frame = CGRect(x: 0, y: 64, width: width, height: height)

        var originX : CGFloat = 0
        for photo in images {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: originX, y: 0.0, width: width, height: height)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = photo
            scrollView.addSubview(imageView)
            originX += scrollView.frame.width
        }
        
        scrollView.isScrollEnabled = true // 可以上下滚动
        scrollView.scrollsToTop = true // 点击状态栏时，可以滚动回顶端
        scrollView.bounces = true // 在最顶端或最底端时，仍然可以滚动，且释放后有动画返回效果
        scrollView.isPagingEnabled = true // 分页显示效果
        
        // set up scroll view content size
        scrollView.contentSize.width = scrollView.frame.width*CGFloat(images.count)
    }
}
