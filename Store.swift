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

class Store: CCNode, SKPaymentTransactionObserver {
    
    weak var catapultLabel: CCLabelTTF!
    weak var coinSpawnerLabel: CCLabelTTF!
    weak var coinsLabel: CCLabelTTF!
    
    var list = [SKProduct]()
    var p = SKProduct()
    
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
        
        // Set IAPS
//        if(SKPaymentQueue.canMakePayments()) {
//            print("IAP is enabled, loading")
////            let productID:NSSet = NSSet(objects: "org.cocos2d.Seige.RemoveAds")
////            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject>)
////            request.delegate = self
////            request.start()
//        } else {
//            print("please enable IAPS")
//        }
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
        for product in list {
            let prodID = product.productIdentifier
            if (prodID == "org.cocos2d.Seige.RemoveAds") {
                p = product
                buyProduct()
                break;
            }
        }
    }
    
    func buyProduct() {
        print("buy " + p.productIdentifier)
        let pay = SKPayment(product: p)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().addPayment(pay as SKPayment)
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
        let viewController = CCDirector.sharedDirector().parentViewController!
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        viewController.presentViewController(gameCenterViewController, animated: true, completion: nil)
    }
    
    // Delegate methods
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension Store: SKProductsRequestDelegate {

    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        print("product request")
        let myProduct = response.products
        
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            
            list.append(product )
        }
        GameStateSingleton.sharedInstance.adsEnabled = false
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        print("transactions restored")
        
        var purchasedItemIDS = []
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction 
            
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
            case "org.cocos2d.Seige.RemoveAds":
                print("remove ads")
            default:
                print("IAP not setup")
            }
            
        }
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("add payment")
        
        for transaction:AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            print(trans.error)
            
            switch trans.transactionState {
                
            case .Purchased:
                print("buy, ok unlock iap here")
                print(p.productIdentifier)
                
                let prodID = p.productIdentifier as String
                switch prodID {
                case "org.cocos2d.Seige.RemoveAds":
                    print("remove ads")
                    self.triggerAd()
                default:
                    print("IAP not setup")
                }
                
                queue.finishTransaction(trans)
                break;
                
            case .Failed:
                print("buy error")
                queue.finishTransaction(trans)
                break;
            default:
                print("default")
                break;
                
            }
        }
    }
    
    func finishTransaction(trans:SKPaymentTransaction)
    {
        print("finish trans")
        SKPaymentQueue.defaultQueue().finishTransaction(trans)
    }
    
    func paymentQueue(queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction])
    {
        print("remove trans");
    }
    
}