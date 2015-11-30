import Foundation
import GameKit

class MainScene: CCNode{
    
    func didLoadFromCCB() {
        setUpGameCenter()
    }
    
    func setUpGameCenter() {

        let gameCenterInteractor = GameCenterInteractor.sharedInstance
        
        gameCenterInteractor.authenticationCheck()
        
    }
    
    //Button Methods
    func begin () {
        let productionScene = CCBReader.loadAsScene("Production")
        CCDirector.sharedDirector().replaceScene(productionScene)
    }
    
}

// MARK: Game Center Handling
extension Gameplay: GKGameCenterControllerDelegate {
    
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