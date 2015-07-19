//
//  Gameplay.swift
//  Seige
//
//  Created by Luke Solomon on 7/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Gameplay: CCNode , CCPhysicsCollisionDelegate {
   
    
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
    var enemyHealth: Int = 100 {
        didSet{
            healthLabel.string = "\(enemyHealth)"
        }
    }
    
    
    //CCB LifeCycle
    func didLoadFromCCB () {
        userInteractionEnabled = true
        healthLabel.string = toString(enemyHealth)
        gamePhysicsNode.collisionDelegate = self
    }
    
    override func update(delta: CCTime) {
        
    }
    
    
    //button Methods
    
    func storeButton () {
        
        let storeScene = CCBReader.loadAsScene("Store")
        CCDirector.sharedDirector().replaceScene(storeScene)
        
    }
    
    
    func fire () {
        launchBeam(spawnAProjectile())
    }
    
    func launchBeam (projectile: Projectile) {
        
    }
    
    func spawnAProjectile () -> Projectile {
        //load in projectile
        let newProjectile = CCBReader.load("Projectile") as! Projectile
        
        //set position equal to player spot
        var projectilePosition = player.convertToWorldSpace(CGPoint(x: 100, y: 100))
        newProjectile.position = CGPoint(x: gamePhysicsNode.position.x, y: gamePhysicsNode.position.y / 2)
        
        player.addChild(newProjectile)
        newProjectile.launch()
        
        let launchDirection = CGPoint(x: 1, y: 0)
        let force = ccpMult(launchDirection, 8000)
        
        return newProjectile
    }
    
    
    //Physics
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, projectile: CCNode!, enemy: CCNode!) -> Bool {
        println("fizzix")
        player.removeChild(projectile)
        enemyHealth -= 1
        return true
    }
    
    

}
