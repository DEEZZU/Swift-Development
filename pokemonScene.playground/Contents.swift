//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit
import Foundation
import GameKit

class TouchableSrpiteNode : SKSpriteNode
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.25)
        fadeOutAction.timingMode = .easeInEaseOut
        
        self.run(fadeOutAction, completion: {
            
            self.removeFromParent()
        })
        
    }
}


class FirstScene: SKScene {
    
    private var label : SKLabelNode!
    private var spinnyNode : SKShapeNode!
    let wwdcIconName = "wwdcIcon"
    let buttonNodeName = "button"
    var lineWiseX : CGFloat = 200
    var lineWiseY : CGFloat = 0
    var jumpedAhead = false
    let allFig: [String] = ["Poki2","Poki3","Poki5","Poki6","Poki7","Poki9","Poki10","Poki11"]
    private var spiralDirection : CGFloat = 1
    private var rounds : CGFloat = 0
    private var iterator = 0
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        
        
        let background = SKSpriteNode(imageNamed: "image.jp2")
        background.name = "background"
        //background.setScale(2.8)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        let welcome = SKSpriteNode(imageNamed: "poke.png")
        welcome.size = CGSize(width:250, height:100)
        welcome.position = CGPoint(x: self.frame.midX, y: self.frame.midY+50)
        welcome.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: welcome.frame.width * 1 , height: welcome.frame.height * 1))
        welcome.physicsBody?.isDynamic = false
        welcome.alpha = 1
        welcome.name = "play"
        welcome.zPosition = 3
        addChild(welcome)
        
      /*  let gameName = "Poke"
        let welcome = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        welcome.text = gameName
        welcome.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: welcome.frame.width * 1.25 , height: welcome.frame.height * 1.25))
        welcome.physicsBody?.isDynamic = false
        welcome.fontSize = 50
        welcome.fontColor = SKColor.yellow
        welcome.position = CGPoint(x: self.frame.midX, y:self.frame.midY+30)
        welcome.alpha = 1
        welcome.zPosition = 3
        addChild(welcome)*/
        
        let slugText = "the Pokemon"
        let slug = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        slug.text = slugText
        slug.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: slug.frame.width * 0.25 , height: slug.frame.height * 0.25))
        slug.physicsBody?.isDynamic = false
        slug.fontSize = 25
        slug.fontColor = SKColor.white
        slug.position = CGPoint(x: self.frame.midX, y:self.frame.midY-10)
        slug.alpha = 1
        slug.zPosition = 3
        addChild(slug)
        
        let playButton = SKSpriteNode(imageNamed: "ball")
        playButton.size = CGSize(width: 70, height: 70)
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY-60)
        playButton.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playButton.frame.width * 1 , height: playButton.frame.height * 1))
        playButton.physicsBody?.isDynamic = false
        playButton.alpha = 1
        playButton.name = "play"
        playButton.zPosition = 3
        addChild(playButton)
        
        addCircularDinoElements()
       
        
    }
    
    func addCircularDinoElements()
    {
        print(self.frame.height, self.frame.width)
        physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)
        let wait = SKAction.wait(forDuration:0.4)
        
        let action = SKAction.run {
            
            let point = CGPoint(x: self.lineWiseX, y: self.lineWiseY)
            self.createNextDino(at: point,rot: self.spiralDirection)
            
            if(self.spiralDirection == 1)
            {
                self.lineWiseX = self.lineWiseX + 150
                print(self.lineWiseX, self.lineWiseY)
                if(self.lineWiseX >= 540)
                {
                    self.lineWiseX = 640
                   // self.jumpedAhead = false
                    self.spiralDirection=2
                    self.lineWiseY = 200
                }
            }
           else if(self.spiralDirection==2)
            {
                self.lineWiseY = self.lineWiseY + 150
                print(self.lineWiseX, self.lineWiseY)
                if(self.lineWiseY >= self.frame.height)
                {
                    self.lineWiseY = self.frame.height
                   // self.jumpedAhead = false
                    self.spiralDirection=3
                    self.lineWiseX = 540
                    
                }
            }
            else if(self.spiralDirection==3)
            {
                self.lineWiseX = self.lineWiseX - 150
                print(self.lineWiseX, self.lineWiseY)
                if(self.lineWiseX < 0)
                {
                    self.lineWiseX = 0
                    self.lineWiseY = 400
                    self.spiralDirection=4
                    //self.rounds+=1
                }
            }
            else if(self.spiralDirection==4)
            {
                self.lineWiseY = self.lineWiseY - 150
                print(self.lineWiseX, self.lineWiseY)
                if(self.lineWiseY < 100 )
                {
                    self.rounds+=1
                   // print(self.rounds)
                }
            }
            if(self.rounds==1)
            {
                self.removeAllActions()
               // print("control is here")
            }
        }//action
        run(SKAction.repeatForever(SKAction.sequence([wait, action])))
       /* run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))
        run(SKAction.sequence([wait, action]))*/
       // print("ended")
    }//func
    
    func createNextDino(at point: CGPoint,rot rotation:CGFloat) {
       // let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: allFig.count)
       // print(randomIndex)
        let index = self.iterator
        self.iterator+=1
        if (self.iterator >= allFig.count){
            self.iterator = 0
        }
        let shape = SKSpriteNode()
        shape.texture = SKTexture(imageNamed: allFig[index])
        shape.name = "textureFig"
        shape.size = CGSize(width:200, height: 200)
        shape.position = CGPoint(x: point.x, y: point.y)
        let maxRadius = max(shape.frame.size.width/2, shape.frame.size.height/2)
        let interPersonSeparationConstant: CGFloat = 0.25
        shape.physicsBody = SKPhysicsBody(circleOfRadius: maxRadius*interPersonSeparationConstant)
        if(rotation==2){
            shape.zRotation = CGFloat(Double.pi/2)
        }
        else if(rotation==3)
        {
            shape.zRotation = CGFloat(Double.pi)
        }
        else if(rotation==4)
        {
            shape.zRotation = CGFloat((Double.pi/2 )*3)
        }
        addChild(shape)
        
        let comeInBelow = SKAction.moveBy(x:0 , y:50 , duration:0.5)
        let comeInRight = SKAction.moveBy(x:-50 , y:0 , duration:0.4)
        let comeInUp = SKAction.moveBy(x:0 , y:-50 , duration:0.3)
        let comeInLeft = SKAction.moveBy(x:50 , y:0 , duration:0.2)
        if(rotation==1){
            shape.run(comeInBelow)
        }
        if(rotation==2){
             shape.run(comeInRight)
        }
        else if(rotation==3)
        {
             shape.run(comeInUp)
        }
        else if(rotation==4)
        {
             shape.run(comeInLeft)
        }
        
    }
    
   /* override public func didSimulatePhysics() {
        super.didSimulatePhysics()
             print("now here ?")
            }
    */
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = FirstScene(size: CGSize(width: 640, height: 480))
scene.scaleMode = .aspectFill

// Present the scene
sceneView.presentScene(scene)


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

