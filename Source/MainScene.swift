import Foundation

class MainScene: CCNode{
    

    func begin () {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().replaceScene(gameplayScene)

    }
    
//    
//    func authenticateLocalPlayer()
//    {
//        self.delegate?.willSignIn()
//        
//        self.localPlayer.authenticateHandler = {(viewController : UIViewController!, error : NSError!) -> Void in
//            
//            if (error)
//            {
//                self.delegate?.failedToSignInWithError(error)
//            }
//            
//            if (viewController != nil)
//            {
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.showAuthenticationDialogueWhenReasonable(viewController)
//                })
//            }
//                
//            else
//            {
//                if (self.localPlayer.authenticated == true)
//                {
//                    println("Player is Authenticated")
//                    self.registerListener()
//                    self.downloadCachedMatches()
//                    self.delegate?.didSignIn()
//                }
//                    
//                else
//                {
//                    println("User Still Not Authenticated")
//                    self.delegate?.failedToSignIn()
//                }
//            }
//        }
//    }


}
