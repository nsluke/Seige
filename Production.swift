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

        score = GameStateSingleton.sharedInstance.score
        coinsPerSecond = GameStateSingleton.sharedInstance.coinsPerSecond
        
        schedule("tickCoinsPerSecond", interval: 1.0)
    }
    
    override func fixedUpdate (delta: CCTime) {
        //Consider using this function.
    }
    
    func tickCoinsPerSecond() {
        score = score + coinsPerSecond
    }
    
    func tap () {
        score = score + 1
    }
    
    func store () {
        GameStateSingleton.sharedInstance.score = score
        
        let storeScene = CCBReader.loadAsScene("Store")
        CCDirector.sharedDirector().replaceScene(storeScene)
        unschedule("tickCoinsPerSecond")

    }
    
    func seige () {
        GameStateSingleton.sharedInstance.score = score
        
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().replaceScene(gameplayScene)
        unschedule("tickCoinsPerSecond")
    }
    
}