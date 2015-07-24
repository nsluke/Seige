//
//  Gameplay.swift
//  Seige
//
//  Created by Luke Solomon on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Gameplay: CCNode {
    
    //Labels
    weak var healthLabel:CCLabelTTF!
    //Button
    weak var fireButton:CCButton!
    //Nodes
    weak var player:CCNode!
    weak var enemy:CCNode!
    weak var gamePhysicsNode:CCPhysicsNode!
    
    //Arrays
    var projectiles : [CCNode] = []
    
    //Constants
    var SW = CCDirector.sharedDirector().viewSize().width
    
        //values
    var score: Int! {
        didSet{
            GameStateSingleton.sharedInstance.score = score
        }
    }
    
    var enemyHealth: Int! {
        didSet{
            healthLabel.string = "\(enemyHealth)"
            GameStateSingleton.sharedInstance.enemyHealth = enemyHealth
            
            if enemyHealth <= 0 {
                let GameOverScene = CCBReader.loadAsScene("GameOver")
                CCDirector.sharedDirector().replaceScene(GameOverScene)
            }
        }
    }
    
    //CCB LifeCycle
    func didLoadFromCCB () {
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
    
        if GameStateSingleton.sharedInstance.enemyHealth == nil {
            enemyHealth = 100
        } else {
            enemyHealth = GameStateSingleton.sharedInstance.enemyHealth
        }
        
        if GameStateSingleton.sharedInstance.score == nil {
            score = 0
        } else {
            score = GameStateSingleton.sharedInstance.score
        }

        println(enemyHealth)
        
        healthLabel.string = toString(enemyHealth)
    }
    
    override func update(delta: CCTime) {
        
    }
    
    //button Methods
    func storeButton () {
        
        let storeScene = CCBReader.loadAsScene("Store")
        CCDirector.sharedDirector().replaceScene(storeScene)
        
    }
    
    func fire () {
        spawnAProjectile()
    }
    
    func spawnAProjectile ()  {
        //load in projectile
        let newProjectile = CCBReader.load("Projectile") as! Projectile
        
        //set position equal to player spot
        var projectilePosition = player.convertToWorldSpace(CGPoint(x: 100, y: 100))
        newProjectile.position = CGPoint(x: gamePhysicsNode.position.x, y: gamePhysicsNode.position.y / 2)
        
        player.addChild(newProjectile)
        newProjectile.launch()
        
        let launchDirection = CGPoint(x: 1, y: 0)
        let force = ccpMult(launchDirection, 8000)
        
        //return newProjectile
        score = score + 1
        
    }
    
}

extension Gameplay: CCPhysicsCollisionDelegate {
    //Physics
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, projectile: CCNode!, enemy: CCNode!) -> Bool {
        println("fizzix")
        player.removeChild(projectile)
        enemyHealth = enemyHealth - 1
        return true
    }
    
}
