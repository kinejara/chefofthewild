//
//  RestoreHeartsApiClient.swift
//  chefofthewild
//
//  Created by Jorge Villa on 3/10/17.
//  Copyright © 2017 kinejara. All rights reserved.
//

import Foundation
import SwiftyJSON


class RestoreHeartsApiClient {

    class func fetchRestoreHeartsDishes() -> [RestoreHeartsDish] {
        var heartDishes = [RestoreHeartsDish]()
        
        if let path = Bundle.main.path(forResource: "restore_hearts_dishes", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: [])
                let json = JSON(data: jsonData as Data)
                
                for (_, subJson):(String, JSON) in json {
                    let food = subJson["Food"].stringValue
                    let ingridients = subJson["Ingridients"].stringValue
                    let notes = subJson["Notes"].stringValue
                    let effect = subJson["Effect"].stringValue
                    let heartDish = RestoreHeartsDish(food: food, ingredients: ingridients, notes: notes, effect: effect)
                    
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
