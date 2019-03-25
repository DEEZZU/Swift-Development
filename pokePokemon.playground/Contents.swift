/*

 POKE THE POKEMON :
The reminiscences of the favourite cartoon Pokemon is a game designed to let users capture their favourite pokemons. The game is designed to increase hand-eye coordination, decision-making, reasoning and focusing abilities. It allows gamers to sharpen visual acuity. The simplicity of the game allows everyone to enjoy it. It is an interactive way of letting kids learn the concept of angle, relative object position and improve their visual attention.
 
 
 The game has been designed in a way that a lot pokemons at varying speed start dropping from upper edge of the screen. They can appear anywhere on the screen allowing the player to make an aim and capture the pokemon. Here is a twist, players have three lives in a round, if a pokemon goes out of the screen without getting hit, then they will lose their life. If they are able to hold the pokemons from going past them for the given time, the player goes on to the next round.
 
 Seemingly easy, this game can give anxiety to the player battling the speeding pokemons . Practice and precision of tapping the pokemon correctly will be an enjoying as well as learning experience for any kind of player.
 
 # Rules :
 For a given time limit, keep on tapping and capturing on the pokemons appearing on the screen.
 If pokemon goes out of the screen unhit, then you will lose a life.
 There are only 3 lives in a given in each of 100 rounds
 * Round 1 - Round  10:  Time - 7 Seconds
 * Round 11 - Round 20 :  Time - 10 Seconds
 * Round 21 - Round 30 :  Time - 12 Seconds
 * Round 31 - Round 45 :  Time - 15 Seconds
 * Round 46 - Round 65 :  Time - 17 Seconds
 * Round 66 - Round 85 :  Time - 20 Seconds
 * Round 86 - Round 100 :  Time - 25 Seconds
 
 Developed By :  Deepti Sharma
 */

import PlaygroundSupport
import SpriteKit
import Foundation



let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = PokeScene(size: CGSize(width: 640, height: 480))
scene.scaleMode = .aspectFill

// Present the scene
sceneView.presentScene(scene)


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

