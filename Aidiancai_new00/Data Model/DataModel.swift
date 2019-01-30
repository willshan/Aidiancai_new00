//
//  File.swift
//  Aidiancai_new00
//
//  Created by Jinshi Feng on 2018/10/6.
//  Copyright © 2018年 单志伟. All rights reserved.
//

import Foundation

class DataModel {
  var categories = [Category]()
  var dishes = [Dish]()
  init() {
    //fake dishes
    let dish1 = Dish(name: AssetsExample.dapanji, pics: [AssetsExample.dapanji], dishType: DishType.hotDish)
    let dish2 = Dish(name: AssetsExample.gongbaojiding, pics: [AssetsExample.gongbaojiding], dishType: DishType.hotDish)
    let dish3 = Dish(name: AssetsExample.huiguorou, pics: [AssetsExample.huiguorou], dishType: DishType.hotDish)
    let dish4 = Dish(name: AssetsExample.jiangxiaobai, pics: [AssetsExample.jiangxiaobai], dishType: DishType.drink)
    let dish5 = Dish(name: AssetsExample.jiangniurou, pics: [AssetsExample.jiangniurou], dishType: DishType.coldDish)
    let dish6 = Dish(name: AssetsExample.kaoya, pics: [AssetsExample.kaoya], dishType: DishType.hotDish)
    let dish7 = Dish(name: AssetsExample.kele, pics: [AssetsExample.kele], dishType: DishType.drink)
    let dish8 = Dish(name: AssetsExample.koushuiji, pics: [AssetsExample.koushuiji], dishType: DishType.coldDish)
    let dish9 = Dish(name: AssetsExample.suantangfeiniu, pics: [AssetsExample.suantangfeiniu], dishType: DishType.hotDish)
    let dish10 = Dish(name: AssetsExample.wanglaoji, pics: [AssetsExample.wanglaoji], dishType: DishType.drink)
    let dish11 = Dish(name: AssetsExample.wuliangye, pics: [AssetsExample.wuliangye], dishType: DishType.drink)
    let dish12 = Dish(name: AssetsExample.xuehuapijiu, pics: [AssetsExample.xuehuapijiu], dishType: DishType.drink)
    let dish13 = Dish(name: AssetsExample.yangrouchuang, pics: [AssetsExample.yangrouchuang], dishType: DishType.hotDish)
    let dish14 = Dish(name: AssetsExample.yutoudoufutang, pics: [AssetsExample.yutoudoufutang], dishType: DishType.hotDish)
    let dish15 = Dish(name: AssetsExample.zhaji, pics: [AssetsExample.zhaji], dishType: DishType.hotDish)
    let dish16 = Dish(name: AssetsExample.zhendingji, pics: [AssetsExample.zhendingji], dishType: DishType.coldDish)
    let dish17 = Dish(name: AssetsExample.aogute, pics: [AssetsExample.aogute], dishType: DishType.drink)
    dishes = [dish1, dish2, dish3, dish4, dish5, dish6,dish7, dish8, dish9,dish10, dish11,dish12, dish13, dish14, dish15, dish16, dish17,] as! [Dish]

    Favorite.share.removeAllDishID()
    Favorite.share.addFavoriteDishID(dishID: (dish1?.dishID.value.uuidString)!)
    Favorite.share.addFavoriteDishID(dishID: (dish5?.dishID.value.uuidString)!)
    Favorite.share.addFavoriteDishID(dishID: (dish8?.dishID.value.uuidString)!)
    
    //早餐
    let category1 = Category(name: "早餐")
    categories.append(category1)
    
    //正餐
    let category2 = Category(name: "正餐")
    
    let restaurant1 = Restaurant()
    restaurant1.name = RestaurantsExample.donglaishun
    restaurant1.cuisine = "北京清真涮羊肉"
    restaurant1.reviews = 200
    restaurant1.favorableRate = 4
    restaurant1.introduction = "中华老字号“东来顺”，始建于1903年，1955年实现公私合营。1988年以东来顺品牌为核心的北京东安饮食公司成立，公司发挥老字号品牌优势，涉足连锁产业开发、品牌半成品、成品研发等领域，为企业的可持续发展注入了活力。1996年，东来顺连锁总部成立，老字号东来顺走上了特许加盟的连锁发展道路。"
    category2.restaurants.append(restaurant1)
    
    let restaurant2 = Restaurant()
    restaurant2.name = RestaurantsExample.quanjude
    restaurant2.cuisine = "北京烤鸭"
    restaurant2.reviews = 2500
    restaurant2.favorableRate = 4
    restaurant2.introduction = "原料：北京填鸭、荷叶饼、空心芝麻烧饼。\n调料：甜面酱、葱、黄瓜、糖、蒜泥。\n质量标准：枣红色，咸鲜，酱香味浓，皮酥肉嫩。\n全聚德烤鸭历史悠久、蜚声中外的全聚德烤鸭采用挂炉、明火烧果木的方法烤制而成。烤鸭成熟时间为45分钟左右。其成品特点是：刚烤出的鸭子皮质酥脆，肉质鲜嫩，飘逸着果木的清香。鸭体形态丰盈饱满，全身呈均匀的枣红色，油光润泽，赏心悦目。配以荷叶饼、葱、酱食之，腴美醇厚，回味不尽。"
    category2.restaurants.append(restaurant2)
    
    let restaurant3 = Restaurant()
    restaurant3.name = RestaurantsExample.baijishuijiao
    restaurant3.cuisine = "水饺"
    restaurant3.reviews = 2689
    restaurant3.favorableRate = 3
    restaurant3.introduction = "白记水饺始于1930年，最早在鸟市游艺场制售，因其创始人白文华而得名。它是用冷面团作皮，包上牛肉、羊肉两种馅心，煮制而成。"
    category2.restaurants.append(restaurant3)
    
    let restaurant4 = Restaurant()
    restaurant4.name = RestaurantsExample.guishunzhai
    restaurant4.cuisine = "天津糕点"
    restaurant4.reviews = 896586
    restaurant4.favorableRate = 5
    restaurant4.introduction = "桂顺斋是天津有名的清真糕点店，因其糕点味道好，做工细，品种多，而驰名中外。\n该店创办于1924年，原是前店后厂，自产自销。所生产的萨其玛、蜜麻花、蜜供、排岔等宫廷糕点色、香、味具佳，成为该店的特色糕点。京剧大师马连良、相声泰斗马三立等，当年常买桂顺斋的糕点。解放后，桂顺斋成为三个门市部，两个作坊。1981年，为了更好地创老字号名牌产品．桂顺斋将两个作坊合并，成立了桂顺斋糕点厂，并形成了一厂五个门市部的格局。糕点厂专门生产各式传统风味糕点及汤圆，供应各门市部销售。\n桂顺斋糕点厂产品已有7大类170多个品种，在各式清真糕点基础上，又研制出黄油、低糖等系列食品。其双羊牌一品桃糕和萨其玛曾连续7年获商业部及天津市名优产品称号，并在1988年中国首届传统食品博览会上获得银牌奖。"
    category2.restaurants.append(restaurant4)
    
    let restaurant5 = Restaurant()
    restaurant5.name = RestaurantsExample.deyuelou
    restaurant5.cuisine = "苏帮菜"
    restaurant5.reviews = 986
    restaurant5.favorableRate = 2
    restaurant5.introduction = "蜚声海内外的苏州“得月楼”创建于明嘉靖年间，位于苏州虎丘半塘野芳浜口，为盛苹州太守所筑，距今已有四百多年历史。\n明代戏曲作家张凤翼赠诗“得月楼”云：“七里长堤列画屏，楼台隐约柳条青，山公入座参差见，水调行歌断续听，隔岸飞花游骑拥，到门沽酒客船停，我来常作山公醉，一卧垆头未肯醒”。野芳浜，俗称冶坊浜，位于半塘桥和普济桥之间，同虎丘隔河相望，山水交融，景色优美，从张凤翼的诗中，便可以想象早在四百多年前，得月楼就已经盛极一时，蜚声吴中了。\n沧海桑田，古时的得月楼随着历史的变迁和改朝换代，或经移址和湮灭，只成为历史上的一笔记载，直至清代乾隆年间，仍有不少文人墨客题诗赞美“得月楼”。当年乾隆皇帝下江南的时候，在得月楼用膳，因其菜味道极为鲜美，赐名“天下第一食府”。"
    category2.restaurants.append(restaurant5)
    
    categories.append(category2)
    
    Favorite.share.removeAllRestaurantID()
    Favorite.share.addFavoriteRestaurantID(restaurantID: restaurant1.restaurantID.value.uuidString)
    Favorite.share.addFavoriteRestaurantID(restaurantID: restaurant3.restaurantID.value.uuidString)
    
    //零食
    let category3 = Category(name: "零食")
    categories.append(category3)

    let path = dataFilePath()
    if let data = try? Data(contentsOf: path){
    loadChecklists(data)
    }
  }
    
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Aidiancai.plist")
  }
  
  func loadChecklists(_ data: Data) {
      let decoder = PropertyListDecoder()
      do {
        categories = try decoder.decode([Category].self, from: data)
      }catch{
        print("Error decoding categories array!")
      }
  }
}
