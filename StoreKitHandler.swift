//
//  StoreKitHandler.swift
//  Seige
//
//  Created by Luke Solomon on 8/11/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
import StoreKit

class StoreKitHandler: SKProductsRequest {




}

//    
//    var productsRequest: SKProductsRequest!
//    var _productIdentifiers: NSSet = ["org.cocos2d.Seige.RemoveAds"]
//    var purchasedProductIdentifiers: NSMutableSet!
//    var product: SKProduct?
//    
//    class var sharedInstance : StoreKitHandler {
//        struct Static {
//            static let instance : StoreKitHandler = StoreKitHandler()
//        }
//        return Static.instance
//    }
//    
//    func initWithProductIdentifiers (productIdentifiers: NSSet) {
//        
//        //check this later for errors
//        _productIdentifiers = productIdentifiers
//        
//        //Check for previously purchased products
//        for productIdentifier in productIdentifiers {
//            var productPurchased: Bool = NSUserDefaults.standardUserDefaults().boolForKey(productIdentifier as! String)
//            
//            if productPurchased {
//                purchasedProductIdentifiers.addObject(productIdentifier)
//                println("Previously Purchased: \(productIdentifier)")
//            } else {
//                println("Not Purchased: \(productIdentifier)")
//            }
//            
//            
//        }
//        
//    }
//    
//}
//
//extension StoreKitHandler: SKProductsRequestDelegate {
//
//    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
//        println("Loaded list of products")
//        
//        productsRequest = nil
//        
//        var skProducts: Array = response.products
//        
//        for skProduct in skProducts {
//            println("Found Product: \(skProduct.productIdentifier), \(skProduct.localizedTitle), \(skProduct.price) ")
//        }
//
//    }
//    
//    
//    
//    func request(request: SKRequest!, didFailWithError error: NSError!) {
//        println("Failed to load list of products")
//        productsRequest = nil
//    }
//
//    func requestDidFinish(request: SKRequest!) {
//        
//    }
//}
//
//
//



