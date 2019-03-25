import PlaygroundSupport
import SpriteKit
import Foundation
import GameKit

public class PokeScene : SKScene {
    
    private var label : SKLabelNode!
    let buttonNodeName = "button"
    var lineWiseX : CGFloat = 200
    var lineWiseY : CGFloat = 0
    var jumpedAhead = false
    let allFig: [String] = ["Poki9","Poki11","Poki7","Poki5","Poki6","Poki3","Poki10","Poki2"]
    private var spiralDirection : CGFloat = 1
    private var rounds : CGFloat = 0
    private var iterator = 0
    let action2 = SKAction.playSoundFileNamed("tun4.mp3", waitForCompletion: false)
    
    public override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "image.jp2")
        background.name = "background"
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
        
        let buttonNodeName = "button"
        let button = PlayButton()
        button.name = buttonNodeName
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY-60)
        button.delegate = self
        button.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: button.frame.width * 1.25 , height: button.frame.height * 2.5))
        button.physicsBody?.isDynamic = false
        button.alpha = 0
        let fadeInOut = SKAction.sequence([.fadeIn(withDuration: 0.5),.fadeOut(withDuration: 0.5)])
        button.run(.repeatForever(fadeInOut))
        addChild(button)
        addLinewiseShape()
    }
    
    func addLinewiseShape()
    {
        self.run(action2, withKey: "sound")
        print(self.frame.height, self.frame.width)
        physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)
        
        let wait = SKAction.wait(forDuration:0.4)
        let action = SKAction.run {
            
            let point = CGPoint(x: self.lineWiseX, y: self.lineWiseY)
            self.choosePoke(at: point,rot: self.spiralDirection)
            
            if(self.spiralDirection == 1)
            {
                self.lineWiseX = self.lineWiseX + 150
                print(self.lineWiseX, self.lineWiseY)
                if(self.lineWiseX >= 540)
                {
                    self.lineWiseX = 640
                    // self.jumpedAhead = false
                    self.spiralDirection=2
                    self.lineWiseY = 100
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
                    self.lineWiseX = 440
                    
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
        }
        run(SKAction.repeatForever(SKAction.sequence([wait, action])))
            
    }
    
    func choosePoke(at point: CGPoint, rot rotation: CGFloat) {
        
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
}

extension PokeScene: PlayButtonDelegate {
    func didTapPlay(sender: PlayButton) {
        self.removeAction(forKey: "sound")
        let action = SKAction.playSoundFileNamed("tune3.mp3", waitForCompletion: false)
        self.run(action)
        let transition = SKTransition.crossFade(withDuration: 0)
       
        let scene1 = MainScene(fileNamed:"MainScene")
   //     scene1!.level = 1
  //      let scene1 = MainScene(size: CGSize(width: 640, height: 480))
        scene1!.scaleMode = SKSceneScaleMode.aspectFill
        
        self.scene!.view?.presentScene(scene1!, transition: transition)
        
    }
}
