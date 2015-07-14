import Foundation

class MainScene: CCNode {
    
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
    var enemyHealth:Int = 100
    
    func didLoadFromCCB () {
        userInteractionEnabled = true
        healthLabel.string = toString(enemyHealth)
    }
    
    override func update(delta: CCTime) {
        
    }
    
    func fire () {
        launchBeam(spawnAProjectile())
    }
    
    func spawnAProjectile () -> Projectile {
        //load in projectile
        let newProjectile = CCBReader.load("Projectile") as! Projectile
        
        //set position equal to player spot
        var projectilePosition = player.convertToWorldSpace(CGPoint(x: 100, y: 100))
        
        newProjectile.position = ccpAdd(player.position, CGPoint(x: 0, y: 0))
        
        player.addChild(newProjectile)
        newProjectile.launch()
        projectiles.append(newProjectile)
        
        let launchDirection = CGPoint(x: 1, y: 0)
        let force = ccpMult(launchDirection, 8000)
        
//        newProjectile.physicsBody.applyForce(force)
//        newProjectile.physicsBody.velocity = ccp(100,0)
        
        return newProjectile
    }
    
    func launchBeam (projectile: Projectile) {
        
        
    }
    
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, projectile: CCNode!, enemy: CCNode!) -> Bool {
        
        println("fizzix")
//        projectiles.removeAtIndex(0)
//        player.removeChildByName("newProjectile")
//        
        return true
    }
    
}
