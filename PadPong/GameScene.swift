//
//  GameScene.swift
//  PadPong
//
//  Created by Joe on 8/21/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    /* Overridden functions */
    override func didMove(to view: SKView)
    {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {

    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }

    /* Our functions */
    func touchDown(atPoint pos : CGPoint)
    {

    }
    
    func touchMoved(toPoint pos : CGPoint)
    {

    }
    
    func touchUp(atPoint pos : CGPoint)
    {

    }
    
    // Function to determine if a location is on Player 1's side or not.
    // Useful to streamline moving paddles
    func isPlayerOneSide(point: CGPoint) -> Bool
    {
        // If it's on the left side of the screen...
        return true
        
        // Otherwise it's Player 2... so return...
        //return false
    }
    
    // Function to perform movement... It moves!
    func moveSprite(_ sprite: SKSpriteNode, velocity: CGFloat)
    {
        
    }
    
}
