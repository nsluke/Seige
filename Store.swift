//
//  Store.swift
//  Seige
//
//  Created by Luke Solomon on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit
import GameKit

class Store: CCNode {
    
    weak var catapultLabel: CCLabelTTF!
    weak var coinSpawnerLabel: CCLabelTTF!
        
    override func onEnter() {
        iAdHandler.sharedInstance.loadInterstitialAd()
        iAdHandler.sharedInstance.loadAds(bannerPosition: .Top)
        iAdHandler.sharedInstance.displayBannerAd()
    }
    
    func didLoadFromCCB () {
        catapultLabel.string = "1"
        coinSpawnerLabel.string = "\(GameStateSingleton.sharedInstance.coinsPerSecond)"
        
    }
    
    func purchaseCatapult () {
        
    }
    
    func purchaseCoinSpawner () {
        GameStateSingleton.sharedInstance.score -= 10
        GameStateSingleton.sharedInstance.coinsPerSecond += 1
        coinSpawnerLabel.string = "\(GameStateSingleton.sharedInstance.coinsPerSecond)"
    }
    
    func backToGameplay () {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().replaceScene(gameplayScene)
    }
    
    func backToProduction () {
        let productionScene = CCBReader.loadAsScene("Production")
        CCDirector.sharedDirector().replaceScene(productionScene)
    }
    
    func openGameCenter() {
        showLeaderboard()
    }
    
    func triggerAd() {
        iAdHandler.sharedInstance.displayInterstitialAd()
    }
    
    func triggerBanner() {
        iAdHandler.sharedInstance.setBannerPosition(bannerPosition: .Top)
        iAdHandler.sharedInstance.displayBannerAd()
    }
    
}

// MARK: Game Center Handling
extension Store: GKGameCenterControllerDelegate {
    
    func showLeaderboard() {
        var viewController = CCDirector.sharedDirector().parentViewController!
        var gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        viewController.presentViewController(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Delegate methods
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}