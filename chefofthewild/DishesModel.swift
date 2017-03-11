//
//  DishesModel.swift
//  chefofthewild
//
//  Created by Jorge Villa on 3/10/17.
//  Copyright © 2017 kinejara. All rights reserved.
//

import Foundation

struct DishesModel {
    
    var food: String
    var ingredients: String
    var notes: String
    var effect: String
    
    var details : [String : String] {
        get {
            var details = [String : String]()
            details["Effect"] = self.effect
            details["Ingredients"] = self.ingredients
            details["Notes"] = self.notes
            
            return details
        }
    }
}
