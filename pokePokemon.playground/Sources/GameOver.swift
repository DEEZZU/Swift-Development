import SpriteKit

class GameOver : SKScene {
    
    var level:Int = 0
    init(size: CGSize, won:Bool,level: Int) {
        
        super.init(size: size)
        
        let action = SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: false)
        run(action)
        
        backgroundColor = SKColor.white
        let message = "Boooooooooo!!!"
        let label = SKLabelNode(fontNamed: "BradleyHandITCTT-Bold")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.run() { [weak self] in
                // 5
                guard let `self` = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = MainScene(fileNamed: "MainScene")
                scene!.scaleMode = SKSceneScaleMode.aspectFill
                self.scene!.view?.presentScene(scene!, transition:reveal)
            }
            ]))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
