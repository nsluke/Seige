//
//  File.swift
//  Seige
//
//  Created by Luke Solomon on 7/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
import GameKit

class GameOver : CCNode {
    
    weak var fireBallLabel: CCLabelTTF!
    
    func didLoadFromCCB () {
        
        fireBallLabel.string = "\(GameStateSingleton.sharedInstance.score) Fireballs"
        
        GameStateSingleton.sharedInstance.checkHighScore()
        
        
    }
    
    func leaderboard () {
        showLeaderboard()
    }
    
    func mainMenu () {
        let mainScene = CCBReader.loadAsScene("MainMenu")
        CCDirector.sharedDirector().replaceScene(mainScene)
    }

}

// MARK: Game Center Handling
extension GameOver: GKGameCenterControllerDelegate {
    
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