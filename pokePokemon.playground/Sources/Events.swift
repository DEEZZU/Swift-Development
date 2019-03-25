// events of game are been taken care of in this protocol
// whatever events can cause a game to get over

import PlaygroundSupport
import SpriteKit
import Foundation
import GameKit

protocol GameEvents {
    
    var level: Int { get set }
    var timer: Int {get set}
    var lives: Int { get set }
    
    func gameOver()
    func nextRound()
    func drawLives()
    
}

public class GameLogic {

    var delegate: GameEvents?

    func setupLogic(delegate: GameEvents) {
        self.delegate = delegate
        let level = delegate.level
    }

    func pokemonCrossedUser() {
            self.delegate?.lives -= 1
            self.delegate?.drawLives()
            if self.delegate?.lives == 0 {
                self.delegate?.gameOver()
            }
        
    }
    
}
