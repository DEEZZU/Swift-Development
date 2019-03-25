import SpriteKit
import Foundation
import GameplayKit

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}



struct PhysicsCategory {
    static let none      : UInt32 = 0
    static let all       : UInt32 = UInt32.max
    static let pokemon   : UInt32 = 0b1       // 1
    static let ballCapture : UInt32 = 0b10      // 2
}


public class MainScene: SKScene, GameEvents {
    
    var playerNode: SKSpriteNode?
    var level: Int = 1
    var timer: Int = 0
    var logic: GameLogic?
    var pokemonCaptured = 0
    var levelLabelNode: SKLabelNode?
    var timerLabelNode: SKLabelNode?

    var lifeNodes: [SKSpriteNode] = []
    var lives: Int = 3
    
    func nextRound(){
        let action =  SKAction.run {
            let action1 = SKAction.playSoundFileNamed("nextLevel.mp3", waitForCompletion: false)
            self.run(action1)
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let nextLevelScene = MainScene(fileNamed:"MainScene")
            nextLevelScene!.level = self.level + 1
            nextLevelScene!.lives = self.lives
            nextLevelScene!.scaleMode = SKSceneScaleMode.aspectFill
            self.scene!.view?.presentScene(nextLevelScene!, transition: reveal)
        }
        self.run(SKAction.sequence([SKAction.wait(forDuration : 0.35), action ]))
    }
    
    public override func didMove(to view: SKView) {
        

        
        self.levelLabelNode = childNode(withName: "level") as? SKLabelNode
        self.levelLabelNode?.text = "Round : \(level)"
        self.timerLabelNode = childNode(withName: "timer") as? SKLabelNode
        self.timerLabelNode?.text = String(timer)
        enumerateChildNodes(withName: "//*") {
            node, stop in
            if node.name == "life" {
                self.lifeNodes.append(node as! SKSpriteNode)
            }
        }
        
        self.logic = GameLogic()
        logic?.setupLogic(delegate: self)
        drawLives()
        setupTimer()
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        run(SKAction.repeatForever(SKAction.sequence([ SKAction.run(addPokemon), SKAction.wait(forDuration: 1.0)])))

    }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addPokemon() {

        let spriteGenerator = GKShuffledDistribution(lowestValue: 1, highestValue: 37)
        let pokemon = SKSpriteNode(imageNamed: "Poki\(spriteGenerator.nextInt())" )
        pokemon.size = CGSize(width: 90, height: 90)
        pokemon.zPosition = 2
        pokemon.physicsBody = SKPhysicsBody(rectangleOf: pokemon.size) // 1
        pokemon.physicsBody?.isDynamic = true // 2
        pokemon.physicsBody?.categoryBitMask = PhysicsCategory.pokemon // 3
        pokemon.physicsBody?.contactTestBitMask = PhysicsCategory.ballCapture // 4
        pokemon.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        
        // Determine where to spawn the pokemon along the Y axis
        let randomX = random(min: -frame.width/2+40 , max: frame.width/2-40)
        print(randomX)
        let randomY = random(min: frame.midY+pokemon.size.height , max: frame.height)
        // Position the pokemon slightly off-screen along the upper edge, and along a random position along the Y axis as calculated above
        pokemon.position = CGPoint(x: randomX , y: randomY)
        
        
        addChild(pokemon)
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(4.0))
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: randomX , y: -frame.height/2 ), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        let waitTime = SKAction.wait(forDuration: 0.01)
        let loseAction = SKAction.run() { [weak self] in
            guard let `self` = self else { return }
            self.logic!.pokemonCrossedUser()
        }
        
        pokemon.run(SKAction.sequence([actionMove, loseAction, actionMoveDone, waitTime ]))
    }
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        run(SKAction.playSoundFileNamed("popSound.mp3", waitForCompletion: false))
        let touchLocation = touch.location(in: self)
        
       // Set up initial location for capturing
        let projectile = SKSpriteNode(imageNamed: "ball")
        projectile.size = CGSize(width: 20, height: 20)
        // setup player for detecting position
        self.playerNode = childNode(withName: "player") as? SKSpriteNode
        projectile.position = playerNode!.position
        projectile.zPosition=2
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.ballCapture
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.pokemon
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.pokemon
        projectile.physicsBody?.usesPreciseCollisionDetection = true
       
        
        let offset = touchLocation - projectile.position
        if offset.y < 0 { return }
        addChild(projectile)
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let realDest = shootAmount + projectile.position
        

        let actionMove = SKAction.move(to: realDest, duration: 1.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
   
    }
    
    
    
    func ballCapturedPokemon(ballCapture: SKSpriteNode, pokemon: SKSpriteNode) {
        print("Hit")
        ballCapture.removeFromParent()
        pokemon.removeFromParent()
        pokemonCaptured += 1
  /*      if pokemonCaptured > 3 {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let nextLevelScene = GameOver(size: self.size, won: true)
            view?.presentScene(nextLevelScene, transition: reveal)
        }*/
    }
    
    
}


extension MainScene : SKPhysicsContactDelegate {

    public func didBegin(_ contact: SKPhysicsContact){
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        //print("here")
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.pokemon != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.ballCapture != 0)) {
            if let poki = firstBody.node as? SKSpriteNode,
                let poked = secondBody.node as? SKSpriteNode {
                ballCapturedPokemon(ballCapture: poked, pokemon: poki)
            }
        }
    }

}

extension MainScene {

    func drawLives() {
        if lives < 3 {
            for index in lives...2 {
                let node = lifeNodes[index]
                node.alpha = 0.2
            }
        }
    }
    
    //set timer for each level
    func setupTimer() {
        var timer = 0
        if (level >= 1 && level <=  10) {
            timer = 7
        } else if (level >= 11 && level <=  20) {
            timer = 10
        } else if (level >= 21 && level <=  30) {
            timer = 12
        } else if (level >= 31 && level <=  45) {
            timer = 15
        } else if (level >= 46 && level <=  65) {
            timer = 17
        } else if (level >= 66 && level <=  85) {
            timer = 20
        } else if (level >= 86 && level <=  100) {
            timer = 25
        }
        else {
            self.level=1
            timer = 7
        }
        
        var flag = 0
        let runTimer = timer
        let waitTimer = SKAction.wait(forDuration: 1)
        let actionTimer = SKAction.run {
            self.timerLabelNode?.text = "Time Left : \(timer)"
            if timer == 1 {
                flag = 1
                if (self.lives > 0 ) {
                    self.nextRound()
                }
                else
                {
                    self.gameOver()
                }
            }
            else {
                if flag == 1 {
                    timer = 0
                }
                timer = timer - 1
            }
        }
        run(SKAction.repeat(SKAction.sequence([waitTimer, actionTimer]) , count: runTimer ))
    }
    
    
    func gameOver(){
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOverScene = GameOver(size: self.size, won: false, level: self.level)
        self.view?.presentScene(gameOverScene, transition: reveal)
    }
}

