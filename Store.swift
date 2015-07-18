//
//  Store.swift
//  Seige
//
//  Created by Luke Solomon on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Store: CCNode {
    
    
    
    func didLoadFromCCB () {
        
        
        
    }
    
    
    
    func backToGameplay () {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().replaceScene(gameplayScene)
        
    }
    
}
