//
//  StoreIntroductionViewController.swift
//  Aidiancai_new00
//
//  Created by 单志伟 on 2019/2/24.
//  Copyright © 2019年 单志伟. All rights reserved.
//

import UIKit

class RestaurantIntroductionViewController: UIViewController {
    
    @IBOutlet weak var restaurantIntro: UITextView!
    @IBOutlet weak var favorableRate: FavorableRate!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("**\(restaurant)")
        if restaurant != nil {
            restaurantIntro.text = restaurant.introduction
            favorableRate.favorableRate = restaurant.favorableRate
            reviewsLabel.text = "\(restaurant.reviews)"
        }
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
