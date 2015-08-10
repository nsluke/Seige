//
//  Store.swift
//  Seige
//
//  Created by Luke Solomon on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit
import GameKit
import StoreKit

class Store: CCNode {
    
    weak var catapultLabel: CCLabelTTF!
    weak var coinSpawnerLabel: CCLabelTTF!
    weak var coinsLabel: CCLabelTTF!
    
    var coinSpawnerCost: Int = 10 {
        didSet{
            coinSpawnerCost = coinSpawnerCost * 2
        }
    }
        
    override func onEnter() {
        iAdHandler.sharedInstance.loadInterstitialAd()
        iAdHandler.sharedInstance.loadAds(bannerPosition: .Top)
        iAdHandler.sharedInstance.displayBannerAd()
    }
    
    func didLoadFromCCB () {
        catapultLabel.string = "1"
        coinSpawnerLabel.string = "\(GameStateSingleton.sharedInstance.coinsPerSecond)"
        coinsLabel.string = "\(GameStateSingleton.sharedInstance.score)"
        
        schedule("coinAddition", interval: 1.0)
    }
    
    func coinAddition () {
        GameStateSingleton.sharedInstance.score + GameStateSingleton.sharedInstance.coinsPerSecond
        coinsLabel.string = "\(GameStateSingleton.sharedInstance.score)"
    }
    
    func purchaseCatapult () {
        GameStateSingleton.sharedInstance.score = 0
        GameStateSingleton.sharedInstance.coinsPerSecond = 0
    }
    
    func purchaseCoinSpawner () {
        if GameStateSingleton.sharedInstance.score >= 10 {
            GameStateSingleton.sharedInstance.score -= 10
            GameStateSingleton.sharedInstance.coinsPerSecond += 1
            coinSpawnerLabel.string = "\(GameStateSingleton.sharedInstance.coinsPerSecond)"
        }
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
    
    func purchaseNoAds (){
        
    }
    
    func triggerBanner() {
//        iAdHandler.sharedInstance.setBannerPosition(bannerPosition: .Top)
//        iAdHandler.sharedInstance.displayBannerAd()
        
        if GameStateSingleton.sharedInstance.adsEnabled == true {
            iAdHelper.sharedHelper()
            iAdHelper.setBannerPosition(BOTTOM)
            GameStateSingleton.sharedInstance.adsEnabled = false
        } else {
            iAdHelper.sharedHelper()
            iAdHelper.setBannerPosition(BOTTOM)
            iAdHelper.closeBannerView(iAdHelper.sharedHelper().bannerView)
            GameStateSingleton.sharedInstance.adsEnabled = true
        }
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

extension Store: SKProductsRequestDelegate {

    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
        var count: Int = response.products.count
        if (count > 0) {
            var validProducts = response.products
            var product = validProducts[0] as! SKProduct
            buyProduct(product)
        } else {
            //something went wrong with lookup, try again?
        }
    }
    
    func buyProduct(product: SKProduct) {
        var payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
}