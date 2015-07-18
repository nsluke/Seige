//
//  GameCenterInteractor.swift
//  GameKitInteraction
//
//  Created by Stuart Breckenridge on 19/11/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import UIKit
import GameKit

protocol GameCenterInteractorNotifications
{
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
    func authenticationCheck()
    {
        if (self.localPlayer.authenticated == false)
        {
            //Authenticate the player
            println("The local player is not authenticated.")
            self.authenticateLocalPlayer()
        } else
        {
            println("The local player is authenticated")
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
        
        self.localPlayer.authenticateHandler = {(viewController : UIViewController!, error : NSError!) -> Void in
            
            if (viewController != nil)
            {
                dispatch_async(dispatch_get_main_queue(), {
                    self.showAuthenticationDialogueWhenReasonable(presentingViewController: self.callingViewController!, gameCenterController: viewController)
                })
            }
                
            else if (self.localPlayer.authenticated == true)
            {
                println("Player is Authenticated")
                self.localPlayer.registerListener(self)
                self.delegate?.didSignIn()
            }
                
            else
            {
                println("User Still Not Authenticated")
                self.delegate?.failedToSignIn()
            }
            
            if (error != nil)
            {
                println("Failed to sign in with error:\(error.localizedDescription).")
                self.delegate?.failedToSignInWithError(error)
                // Delegate can take necessary action. For example: present a UIAlertController with the error details.
            }
        }
    }
    
    //MARK: 3 Show Authentication Dialogue
    /**
    When appropriate, this function will be called and will present the Game Center login view controller.
    
    :param: presentingViewController The view controller that will present the game center view controller.
    :param: gameCenterController     The game center controller.
    */
    func showAuthenticationDialogueWhenReasonable(#presentingViewController:UIViewController, gameCenterController:UIViewController)
    {
        presentingViewController.presentViewController(gameCenterController, animated: true, completion: nil)
    }
}

extension GameCenterInteractor:GKLocalPlayerListener
{
    // Add functions for monitoring match changes.
}