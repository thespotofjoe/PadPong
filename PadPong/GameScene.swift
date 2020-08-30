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
    var centerX: CGFloat
    
    var ball = Ball(size: 50)
    
    var paddle1Position: CGPoint = CGPoint(x: 1241,
                                           y: 512)
    var paddle2Position: CGPoint = CGPoint(x: 125,
                                           y: 512)
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    var playerScores:[Int] = [0,0]
    
    /* Overridden functions */
    override init(size: CGSize)
    {
        centerX = size.width / 2
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let potentialPosition = ball.position + willMove
        if (potentialPosition.x < 0 || potentialPosition.x > 1366)
        {
            return true
        }
        
        return false
    }
    
    // If the ball is off one side of the screen, figure out who scored using this function
    func whoScored() -> Int
    {
        // If ball is past Player 2's paddle, Player 1 scored.
        if (whichSideIsItOn(ball.position) == 2)
        {
            return 1
        } else { // If the ball is past Player 1's paddle, Player 2 scored.
            return 2
        }
    }
    
    // Function to determine which side a point is on.
    // Useful to streamline moving paddles and scoring.
    func whichSideIsItOn(_ point: CGPoint) -> Int
    {
        let x = point.x
        
        // If it's in the center, it's on nobody's side, so return 0.
        if x == centerX
        {
            return 0
        }
        
        // If it's on the left side of the screen it's player 1, so return 1.
        if x < centerX
        {
            return 1
        }
        
        // Otherwise it's Player 2... so return...
        return 2
    }
    
    // Function to move the ball.
    func moveBall(velocity: CGPoint)
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
        if willSomeoneScore(willMove: pixelsToMove)
        {
            adjustScore(player: whoScored())
            ball.reset()
        }

        // Coast is clear. Let's move.
        moveNode(ball.shape, delta: pixelsToMove)
    
    }
    
    // Function to perform movement... It moves!
    func moveNode(_ node: SKNode, delta: CGPoint)
    {
        // Let's move.
        node.position = node.position + delta
   
    }
    
}
