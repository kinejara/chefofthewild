//
//  RestoreHeartsApiClient.swift
//  chefofthewild
//
//  Created by Jorge Villa on 3/10/17.
//  Copyright © 2017 kinejara. All rights reserved.
//

import Foundation


class RestoreHeartsApiClient {

    class func fetchRestoreHeartsDishes() -> String {
        
        if let path = Bundle.main.path(forResource: "restore_hearts_dishes", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: [])
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions()) as? [String : AnyObject]
                } catch {
                    
                }
            } catch {
                
            }
        } else {
            
        }
        
        return ""
    }
    
}
