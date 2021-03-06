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
    var centerX = CGFloat.zero
    var height = CGFloat.zero
    var width = CGFloat.zero
    
    var ball = Ball(size: 50)
    var paddles: [Int : Paddle] = [:]
    
    var lastUpdateTime: TimeInterval = 0
    var dt = CGFloat.zero
    
    var playerScores:[Int : Int] = [1: 0, 2: 0]
    var scoreLabels:[Int : SKLabelNode] = [:]
    
    /* Overridden functions */
    override init(size: CGSize)
    {
        height = size.height
        width = size.width
        
        paddles[1] = Paddle(player: 1, screenSize: size)
        paddles[2] = Paddle(player: 2, screenSize: size)
                
        super.init(size: size)
        
        // Connect score labels to code so we can display score changes to the user.
        scoreLabels[1] = self.childNode(withName: "player1ScoreLabel") as! SKLabelNode
        scoreLabels[2] = self.childNode(withName: "player2ScoreLabel") as! SKLabelNode
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //var size = UIScreen.main.bounds.size
        height = size.height
        width = size.width
        
        paddles[1] = Paddle(player: 1, screenSize: size)
        paddles[2] = Paddle(player: 2, screenSize: size)
        
        // Connect score labels to code so we can display score changes to the user.
        scoreLabels[1] = self.childNode(withName: "player1ScoreLabel") as! SKLabelNode
        scoreLabels[2] = self.childNode(withName: "player2ScoreLabel") as! SKLabelNode
    }
    
    override func didMove(to view: SKView)
    {
        ball.addToView(self)
        addChild(paddles[1]!.shape)
        addChild(paddles[2]!.shape)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            touchDown(atPoint: touch.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            touchDown(atPoint: touch.location(in: self))
        }
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        // Is this the first time we run this function?
        if (lastUpdateTime == 0)
        {
            dt = 0
        } else {
            dt = CGFloat(currentTime - lastUpdateTime)
        }
        
        lastUpdateTime = currentTime
        
        // Move the ball.
        ball.move(dt: dt)
        //print("Moved ball. dt: \(dt)")
        
        // Check for collisions.
        if didBallHitPaddle()
        {
            ball.bounceOffVertical()
        }
        
        // Bounce off top and bottom of screen
        if ball.isOutOfYBounds(maxHeight: height)
        {
            ball.bounceOffHorizontal()
        }

        if didSomeoneScore()
        {
            //print("Someone scored!")
            adjustScore(player: whoScored())
            ball.reset()
        }
    }

    /* Our functions */
    func touchDown(atPoint pos : CGPoint)
    {
        let whichPlayer = whichSideIsItOn(pos)
        paddles[whichPlayer]!.moveTo(pos.y)
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        let whichPlayer = whichSideIsItOn(pos)
        paddles[whichPlayer]!.moveTo(pos.y)
    }
    
    func adjustScore(player: Int)
    {
        if player == 1 || player == 2
        {
            playerScores[player]! += 1
            scoreLabels[player]!.text = "\(playerScores[player]!)"
        }
    }
    
    // Detect if the ball will hit the paddle in the next screen update
    func didBallHitPaddle() -> Bool
    {
        if ball.leftX < paddles[1]!.rightX && ball.position.y > paddles[1]!.bottomY && ball.position.y < paddles[1]!.topY
        {
            print("Ball hit left paddle.")
            return true
        }
        
        if ball.rightX > paddles[2]!.leftX && ball.position.y > paddles[2]!.bottomY && ball.position.y < paddles[2]!.topY
        {
            print("Ball hit right paddle")
            return true
        }
        
        return false
    }
    
    // Checks if the ball will go off the screen
    func didSomeoneScore() -> Bool
    {
        if (ball.position.x < -width/2 || ball.position.x > width/2)
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
        ball.move(dt: dt)
    }
    
    // Function to perform movement... It moves!
    func moveNode(_ node: SKNode, delta: CGPoint)
    {
        // Let's move.
        node.position = node.position + delta
    }
    
}
