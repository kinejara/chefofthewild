//
//  DishesApiClient.swift
//  chefofthewild
//
//  Created by Jorge Villa on 3/10/17.
//  Copyright © 2017 kinejara. All rights reserved.
//

import Foundation
import SwiftyJSON


class DishesApiClient {
    
    class func fetchRestoreStaminaDishes() -> [DishesModel] {
        return self.fetchDishesWithPath(path: "restore_stamina_dishes")
    }
    
    class func fetchRestoreHeartsDishes() -> [DishesModel] {
        return self.fetchDishesWithPath(path: "restore_hearts_dishes")
    }

    class func fetchDishesWithPath(path: String) -> [DishesModel] {
        var heartDishes = [DishesModel]()
        
        if let path = Bundle.main.path(forResource: path, ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: [])
                let json = JSON(data: jsonData as Data)
                
                for (_, subJson):(String, JSON) in json {
                    let food = subJson["Food"].stringValue
                    let ingridients = subJson["Ingredients"].stringValue
                    let notes = subJson["Notes"].stringValue
                    let effect = subJson["Effect"].stringValue
                    let heartDish = DishesModel(food: food, ingredients: ingridients, notes: notes, effect: effect)
                    
                    heartDishes.append(heartDish)
                }
                
                return heartDishes
            } catch {
                return heartDishes
            }
        } else {
            return heartDishes
        }
    }
    
}
