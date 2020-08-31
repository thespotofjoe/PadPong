//
//  Objects.swift
//  PadPong
//
//  Created by Joseph Buchoff on 8/30/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import Foundation
import SpriteKit

class Paddle
{
    var shape: SKShapeNode
    var position: CGPoint
    var paddleX = CGFloat.zero
    var leftX: CGFloat
    var rightX: CGFloat
    var topY: CGFloat
    var bottomY: CGFloat
    
    var paddleWidth = CGFloat(50)
    var paddleHeight = CGFloat(200)

    init (player: Int, screenSize: CGSize)
    {
        let screenWidth = screenSize.width
        let midHeight = screenSize.height / 2
        
        // Set position to center of screen and velocity to 0
        if player == 1
        {
            paddleX = -(screenWidth * 0.45)
        } else {
            paddleX = screenWidth * 0.45
        }
        position = CGPoint(x: paddleX,
                           y: midHeight)
        
        // Initialize light grey rectangle
        shape = SKShapeNode(rectOf: CGSize(width: paddleWidth, height: paddleHeight))
        shape.position = position
        leftX = paddleX - paddleWidth/2
        rightX = paddleX + paddleWidth/2
        topY = position.y + paddleHeight/2
        bottomY = position.y - paddleHeight/2
        shape.fillColor = UIColor.lightGray
    }
    
    // Function to reduce errors by making 1 place and 1 place only to update the shape's position.
    private func updatePosition(_ newY: CGFloat)
    {
        self.position.y = newY
        shape.position.y = newY
        
        topY = newY + paddleHeight/2
        bottomY = newY - paddleHeight/2
    }
    
    func moveTo(_ newY: CGFloat)
    {
        self.updatePosition(newY)
    }
}
