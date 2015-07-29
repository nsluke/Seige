//
//  Production.swift
//  Seige
//
//  Created by Luke Solomon on 7/28/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Production: CCNode {
    
    var score: Int! {
        didSet{
            coinLabel.string = "Coins: \(score)"
        }
    }
    
    var coinsPerSecond:Int! {
        didSet{
            coinsPerSecondLabel.string = "Coins per second: \(coinsPerSecond)"
        }
    }
    
    weak var coinLabel: CCLabelTTF!
    weak var coinsPerSecondLabel: CCLabelTTF!
    
    func didLoadFromCCB () {
//        if score == nil {
//            score = 0
//        }
//        
//        if coinsPerSecond == nil {
//            coinsPerSecond = 0
//        }
        
//        if GameStateSingleton.sharedInstance.score == nil {
//            score = 0
//        } else {
            score = GameStateSingleton.sharedInstance.score
            coinsPerSecond = GameStateSingleton.sharedInstance.coinsPerSecond
//        }
    }
    
    override func fixedUpdate (delta: CCTime) {
        score = score + coinsPerSecond
    }
    
    
    func tap () {
        score = score + 1
    }
    
    func store () {
        GameStateSingleton.sharedInstance.score = score
        
        let storeScene = CCBReader.loadAsScene("Store")
        CCDirector.sharedDirector().replaceScene(storeScene)
    }
    
    func seige () {
        GameStateSingleton.sharedInstance.score = score
        
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().replaceScene(gameplayScene)
    }
    
}