//
//  GameCenterInteractor.swift
//  GameKitInteraction
//
//  Created by Stuart Breckenridge on 19/11/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import UIKit
import GameKit

protocol GameCenterInteractorNotifications {
    func willSignIn()
    func didSignIn()
    func failedToSignInWithError(anError:NSError)
    func failedToSignIn()
}

class GameCenterInteractor: NSObject {
    
    // Public Variables
    let localPlayer = GKLocalPlayer.localPlayer()
    var delegate: GameCenterInteractorNotifications?
    var callingViewController: UIViewController?
    
    // Singleton
    class var sharedInstance : GameCenterInteractor {
        struct Static {
            static let instance : GameCenterInteractor = GameCenterInteractor()
        }
        return Static.instance
    }
    
    //MARK: 1 Check authentication status
    /**
    This is the public method that begins the authentication process for the local player.
    */
    func authenticationCheck() {
        if (self.localPlayer.authenticated == false) {
            //Authenticate the player
            print("The local player is not authenticated.")
            self.authenticateLocalPlayer()
        } else {
            print("The local player is authenticated")
            // Register the listener
            self.localPlayer.registerListener(self)
            
            // At this point you can download match data from Game Center.
        }
    }
    
    //MARK: 2 Authenticate the Player
    /**
    This is a private method to authenticate the local player with Game Center.
    */
    private func authenticateLocalPlayer()
    {
        self.delegate?.willSignIn()
        
        self.localPlayer.authenticateHandler = {(viewController : UIViewController?, error : NSError?) -> Void in
            
            if (viewController != nil)
            {
                dispatch_async(dispatch_get_main_queue(), {
                    self.showAuthenticationDialogueWhenReasonable(presentingViewController: CCDirector.sharedDirector().parentViewController!, gameCenterController: viewController!)
                })
            }
                
            else if (self.localPlayer.authenticated == true)
            {
                print("Player is Authenticated")
                self.localPlayer.registerListener(self)
                self.delegate?.didSignIn()
            }
                
            else
            {
                print("User Still Not Authenticated")
                self.delegate?.failedToSignIn()
            }
            
            if (error != nil)
            {
                print("Failed to sign in with error:\(error!.localizedDescription).")
                self.delegate?.failedToSignInWithError(error!)
                // Delegate can take necessary action. For example: present a UIAlertController with the error details.
            }
        }
    }
    
    //MARK: 3 Show Authentication Dialogue
    /**
    When appropriate, this function will be called and will present the Game Center login view controller.
    
    - parameter presentingViewController: The view controller that will present the game center view controller.
    - parameter gameCenterController:     The game center controller.
    */
    func showAuthenticationDialogueWhenReasonable(presentingViewController presentingViewController:UIViewController, gameCenterController:UIViewController) {
        presentingViewController.presentViewController(gameCenterController, animated: true, completion: nil)
    }
    

    func reportHighScoreToGameCenter() {
        let scoreReporter = GKScore(leaderboardIdentifier: "SeigeLeaderboard")
        scoreReporter.value = Int64(GameStateSingleton.sharedInstance.score)
        let scoreArray: [GKScore] = [scoreReporter]
        
        GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError?) -> Void in
            if error != nil {
                print("Game Center: Score Submission Error")
            }
        })
    }
    
    
}

extension GameCenterInteractor:GKLocalPlayerListener
{
    // Add functions for monitoring match changes.
}