//
//  Singleton.swift
//  Seige
//
//  Created by Luke Solomon on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class GameStateSingleton: NSObject {
    
    var score:Int = NSUserDefaults.standardUserDefaults().integerForKey("score") {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(score, forKey:"score")
        }
    }
    
    var coinsPerSecond: Int = NSUserDefaults.standardUserDefaults().integerForKey("coinsPerSecond") {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(score, forKey:"coinsPerSecond")
        }
    }
    
    var enemyHealth:Int!
    
    class var sharedInstance : GameStateSingleton {
        struct Static {
            static let instance : GameStateSingleton = GameStateSingleton()
        }
        return Static.instance
    }
    
    func checkHighScore () {
        
        if score > NSUserDefaults.standardUserDefaults().integerForKey("score") {
            NSUserDefaults.standardUserDefaults().setObject(score, forKey: "score")
            GameCenterInteractor.sharedInstance.reportHighScoreToGameCenter()
        }
        
    }
    
}
