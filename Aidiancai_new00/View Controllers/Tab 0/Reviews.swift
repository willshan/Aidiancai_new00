//
//  Reviews.swift
//  Aidiancai_new00
//
//  Created by Admin on 2018/11/12.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import UIKit

@IBDesignable class Reviews: UIStackView {
    //MARK: Properties
    private var reviewPics = [UIImageView]()
    
    var reviews = 3 {
        didSet {
            setupStars()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 16.0, height: 16.0){
        didSet {
            setupStars()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }
    
    //superclass里有required，subclass里也必须有
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStars()
    }
    
    //MARK: Private Methods
    //setupStars 先设置一些ImageView，并将它们放在stackview里
    private func setupStars() {
        //先将stars全部去除，
        removeAllStars()
        
        //再重新布置
        addStars(start: 0, end: reviews, pic: AssetsName.greenStar)
        
        if reviews > 4 {
            return
        }
        
        addStars(start: reviews, end: 5, pic: AssetsName.grayStar)
        
    }
    
    private func removeAllStars() {
        //每次调用setupStars方法是，先将view上的Imageview清空，然后再根据新的变量，重新设置view
        for pic in reviewPics {
            //第一步removeArrangedSubview是StackView中的一个方法，它将Imageview从stackview的管理list中去掉，这个Imageview不会再用来计算大小和位置，但是Imageview仍然存在.
            removeArrangedSubview(pic)
            //第二步removeFromSuperview，将Imageview从superview中去掉
            pic.removeFromSuperview()
        }
        //所有Imageview都去掉后，将变量reviewPics清零
        reviewPics.removeAll()
    }
    
    private func addStars(start from : Int, end at : Int, pic name : String) {
        //设置星星
        for _ in from..<at {
            // Create the Imageview
            let imageView = UIImageView()
            
            // Set the Imageview images
            imageView.image = UIImage(named: name)
            
            // Add constraints
            //translatesAutoresizingMaskIntoConstraints是默认的constraint方式，当使用autolayout时，先把它关掉
            imageView.translatesAutoresizingMaskIntoConstraints = false
            //以下两个是将Imageview的高度和宽度，设置成和star的高度宽度一致。
            imageView.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Add the Imageview to the stack
            addArrangedSubview(imageView)
            
            reviewPics.append(imageView)
        }
    }
}
