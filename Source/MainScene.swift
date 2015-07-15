import Foundation

class MainScene: CCNode{
    

    func begin () {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().replaceScene(gameplayScene)

    }



}
