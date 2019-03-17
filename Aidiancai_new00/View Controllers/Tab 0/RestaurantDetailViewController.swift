//
//  RestaurantDetailViewController.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/1/30.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmental: UISegmentedControl!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    @IBAction func isFavorite(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            Favorite.share.removeFavoriteRestaurantID(restaurantID: restaurant.restaurantID)
        }
        else {
            sender.isSelected = true
            Favorite.share.addFavoriteRestaurantID(restaurantID: restaurant.restaurantID)
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmental.selectedSegmentIndex {
        case 0:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let restaurantIntroductionViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardID.restaurantIntroductionViewController) as! RestaurantIntroductionViewController
            restaurantIntroductionViewController.restaurant = self.restaurant
            
            self.replaceController(oldVC: currentVC, newVC: restaurantIntroductionViewController)
            print("segment index 0 was tapped")
            
        case 1:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let dishListViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardID.dishListViewController) as! DishListViewController
            
            dishListViewController.dishes = dishes
            dishListViewController.restaurant = restaurant
            dishListViewController.mealCatagory = mealCatagory
            dishListViewController.orderTemp = orderTemp

            print("segment index 1 was tapped")
            self.replaceController(oldVC: currentVC, newVC: dishListViewController)
            
        default:
            return
        }
    }
    
    //dishes are dishes in specified restaurant
    var dishes : [Dish]!
    var restaurant : Restaurant!
    var mealCatagory : String!
    var orderTemp: OrderTemp! //Injection var
    var currentVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContaienrView()
        tableView.contentInset = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
        setupViews()
        setupNavigationBar(offset: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("the height of cell is \(UIScreen.main.bounds.height - 40-64)")
        print("the height of contianer view is \(containerView.frame.height)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return pic.frame.height
        case 1:
            return 40
        case 2:
            return UIScreen.main.bounds.height - 40-64
        default:
            return 44
        }
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        setupNavigationBar(offset: offset)
    }
}

extension RestaurantDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension RestaurantDetailViewController {
    func setupContaienrView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let restaurantIntroductionViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardID.restaurantIntroductionViewController) as! RestaurantIntroductionViewController
        restaurantIntroductionViewController.restaurant = self.restaurant
        
        self.addChildViewController(restaurantIntroductionViewController)
        restaurantIntroductionViewController.view.frame = containerView.frame
        self.containerView.addSubview(restaurantIntroductionViewController.view)
        restaurantIntroductionViewController.didMove(toParentViewController: self)
            
        currentVC = restaurantIntroductionViewController
    }
    
    func replaceController(oldVC : UIViewController, newVC : UIViewController) {
        print("func replaceController was used")
        // Prepare the two view controllers for the change
        oldVC.willMove(toParentViewController: nil)
        self.addChildViewController(newVC)
        
        // Get the start frame of the new view controller and the end frame
        // for the old view controller. Both rectangles are offscreen.
        newVC.view.frame = self.containerView.frame
        let endFrame = self.containerView.frame
       
        self.transition(from: oldVC, to: newVC, duration: 0.5, options: [], animations: {
            // Animate the views to their final positions.
            newVC.view.frame = oldVC.view.frame
            oldVC.view.frame = endFrame
            
        }) { (success) in
            if success {
                print("success")
                oldVC.removeFromParentViewController()
                newVC.didMove(toParentViewController: self)
                self.currentVC = newVC
            }
            else {
                print("fail")
                self.currentVC = oldVC
            }
        }
    }
    
    func setupNavigationBar(offset:CGFloat) {
        let offsetTotal = pic.frame.height-64
        if offset<offsetTotal {
            //滑倒顶部之前
            let coloralph = offset/offsetTotal
            pic.alpha = 1 - coloralph
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) //将navigation bar背景设成空白图片
            self.navigationController?.navigationBar.shadowImage = UIImage() //将navigation bar与view的分界线设成空白图片，不设的话，会有一条线
            
            self.title = ""
        }else{
            //滑动超过导航栏底部
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.title = restaurant.name
        }
    }
    
    func setupViews() {
//        favorableRate.favorableRate = restaurant.favorableRate
//        reviewsLabel.text = "\(restaurant.reviews)"+"人评价"
        nameLabel.text = restaurant.name
//        restaurantIntro.text = restaurant.introduction
        
        favoriteButton.setTitle("已收藏", for: .selected)
        favoriteButton.setTitle("未收藏", for: .normal)
        if Favorite.share.isRestaurantFavorite(restaurantID: restaurant.restaurantID) {
            favoriteButton.isSelected = true
        }
        else {
            favoriteButton.isSelected = false
        }
        // Remove constraints and turn off Auto Layout
        pic.removeConstraints(pic.constraints)
        pic.translatesAutoresizingMaskIntoConstraints = true
        
        let width = UIScreen.main.bounds.width
        let height = (UIScreen.main.bounds.height - 64)/3
        pic.frame = CGRect(x: 0, y: 0, width: width, height: height)
        pic.image = UIImage(named: restaurant.name) ?? UIImage(named: AssetsExample.defaultPhoto)
    }
}
/*
class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmental: UISegmentedControl!
    @IBOutlet weak var restaurantIntro: UITextView!
    @IBOutlet weak var favorableRate: FavorableRate!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func isFavorite(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            Favorite.share.removeFavoriteRestaurantID(restaurantID: restaurant.restaurantID.value.uuidString)
        }
        else {
            sender.isSelected = true
            Favorite.share.addFavoriteRestaurantID(restaurantID: restaurant.restaurantID.value.uuidString)
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmental.selectedSegmentIndex {
        case 1:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let dishListViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardID.dishListViewController) as! DishListViewController
            
            dishListViewController.dishes = dishes
            dishListViewController.restaurant = restaurant
            dishListViewController.mealCatagory = mealCatagory
            dishListViewController.orderTemp = orderTemp
            self.navigationController?.pushViewController(dishListViewController, animated: true)
            
        default:
            return
        }
    }
    
    //dishes are dishes in specified restaurant
    var dishes : [Dish]!
    var restaurant : Restaurant!
    var mealCatagory : String!
    var orderTemp: OrderTemp! //Injection var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segmental.selectedSegmentIndex = 0
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) //将navigation bar背景设成空白图片
        self.navigationController?.navigationBar.shadowImage = UIImage() //将navigation bar与view的分界线设成空白图片，不设的话，会有一条线
//        self.navigationController?.navigationBar.isTranslucent = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
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
 */

