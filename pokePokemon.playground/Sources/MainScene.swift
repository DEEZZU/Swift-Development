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


public class MainScene: SKScene {
    
    var playerNode: SKSpriteNode?
    var level: Int = 1
   // var timer:Int = 0
   // var logic: GameActions?
    
    var levelLabelNode: SKLabelNode?
  //  var timerLabelNode: SKLabelNode?
  //  var rightFigureNode: SKSpriteNode?
  //  var deckNodes: [SKSpriteNode] = []
  //  var deckNodesName: [String] = []
    var lifeNodes: [SKSpriteNode] = []
    var lives: Int = 3
    
    
    public override func didMove(to view: SKView) {
        
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
        
        pokemon.run(SKAction.sequence([actionMove, actionMoveDone,waitTime]))
    }
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
       // Set up initial location for capturing
        let projectile = SKSpriteNode(imageNamed: "ball")
        projectile.size = CGSize(width: 20, height: 20)
        // setup player for detecting position
        self.playerNode = childNode(withName: "player") as? SKSpriteNode
        projectile.position = playerNode!.position
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.ballCapture
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.pokemon
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
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
    }
    
    
}


extension MainScene : SKPhysicsContactDelegate {
    

    func didBegin(_ contact: SKPhysicsContact){
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        print("here")
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
    
    /*
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    */
}
