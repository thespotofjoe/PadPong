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
    
    /* Properties */
    let maxBallMovement = 400
    var ballPosition: CGPoint = CGPoint(x: 683,
                                         y: 512)
    
    var paddle1Position: CGPoint = CGPoint(x: 1241,
                                           y: 512)
    var paddle2Position: CGPoint = CGPoint(x: 125,
                                           y: 512)
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    var playerScores:[Int] = [0,0]
    
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
        // Is this the first time we run this function?
        if (lastUpdateTime == 0)
        {
            dt = 0
        } else {
            dt = currentTime - lastUpdateTime
        }
        
        lastUpdateTime = currentTime
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
    
    func adjustScore(player: Int)
    {
        playerScores[player] += 1
    }
    
    // Detect if the ball will hit the paddle in the next screen update
    func willBallHitPaddle(ballWillMove: CGPoint) -> Bool
    {
        // Calculate next position if ball moves
        // Detect whether this position is either touching or inside Paddle1
            // If it is, return true
        // Detect whether this position is either touching or inside Paddle2
            // If it is, return true
        // If we got here, it won't hit the paddle, so return false
        return false
    }
    
    // Checks if the ball will go off the screen
    func willSomeoneScore(willMove: CGPoint) -> Bool
    {
        if (ballPosition.x + willMove.x < 0 || ballPosition.x + willMove.x > 1366)
        {
            return true
        }
        
        return false
    }
    
    // If the ball is off one side of the screen, figure out who scored using this function
    func whoScored() -> Int
    {
        // If ball is off right side of the screen, Player 1 scored
        if (whichSideIsItOn(ballPosition) == 2)
        {
            return 1
        } else {
            return 2
        }
    }
    
    // Function that picks a random direction for the ball when starting from center
    func setRandomStartDirection() -> CGFloat
    {
        // TODO Generate random fraction of a circle here
        return 2 * .pi //* randomly generated fraction
    }
    
    // Function to determine if a location is on Player 1's side or not.
    // Useful to streamline moving paddles
    func whichSideIsItOn(_ point: CGPoint) -> Int
    {
        // If it's on the left side of the screen...
        return 1
        
        // Otherwise it's Player 2... so return...
        //return 2
    }
    
    // Function to move the ball
    func moveBall(_ ball: SKSpriteNode, velocity: CGPoint)
    {
        // How much we gonna move?
        let pixelsToMove = CGPoint(x: velocity.x * CGFloat(dt),
                                   y: velocity.y * CGFloat(dt))
        // If we move, will the ball hit the paddle?
        if (willBallHitPaddle(ballWillMove: pixelsToMove))
        {
            // TODO Calculate where ball would be after dt, set var position to it
            //ball.position = position
            return
        }
        
        // If we move the ball, will someone score?
        willSomeoneScore(willMove: pixelsToMove)
        
        // Adjust score accordingly
        adjustScore(player: whoScored())

        // Coast is clear. Let's move.
        moveSprite(ball, pixels: pixelsToMove)
    
    }
    
    // Function to perform movement... It moves!
    func moveSprite(_ sprite: SKSpriteNode, pixels: CGPoint)
    {
        // Let's move.
        sprite.position = CGPoint(x: sprite.position.x + pixels.x,
                                  y: sprite.position.y + pixels.y)
   
    }
    
}
