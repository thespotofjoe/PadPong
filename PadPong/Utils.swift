//
//  Utils.swift
//  PadPong
//
//  Created by Joseph Buchoff on 8/30/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (left: inout CGPoint, right: CGPoint) {
  left = left + right
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func -= (left: inout CGPoint, right: CGPoint) {
  left = left - right
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func * (left: Int, right: Double) -> Double
{
    return Double(left) * right
}

func *= (left: inout CGPoint, right: CGPoint) {
  left = left * right
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func *= (point: inout CGPoint, scalar: CGFloat) {
  point = point * scalar
}

func / (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func /= (left: inout CGPoint, right: CGPoint) {
  left = left / right
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (point: inout CGPoint, scalar: CGFloat) {
  point = point / scalar
}

func atan2(y: CGFloat, x: CGFloat) -> CGFloat {
  return CGFloat(atan2f(Float(y), Float(x)))
}

func sqrt(a: CGFloat) -> CGFloat {
  return CGFloat(sqrtf(Float(a)))
}

extension CGPoint {
    var angle: CGFloat {
      return atan2(y, x)
    }
  
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
  
    func normalized() -> CGPoint {
        return self / length()
    }
    
    static func initWithVelocity(inDirection angle: Double, withSpeed speed: Int) -> CGPoint
    {
        return CGPoint(x: speed * cos(angle),
                       y: speed * sin(angle))
    }
}

class Ball
{
    var shape: SKShapeNode
    var velocity: CGPoint
    var position: CGPoint
    
    let speed = 400

    init (size: Int)
    {
        // Set position to center of screen and velocity to 0
        position = CGPoint.zero
        velocity = CGPoint.zero
        
        // Initialize white square
        shape = SKShapeNode(rectOf: CGSize(width: size, height: size))
        shape.position = position
        shape.fillColor = UIColor.white
    }
    
    // Function to reduce errors by making 1 place and 1 place only to update the shape's position.
    func updatePosition()
    {
        shape.position = position
    }
    
    func move(dt: CGFloat)
    {
        self.position += velocity * dt
        self.updatePosition()
    }
    
    // Resets ball to center
    func reset()
    {
        position = CGPoint.zero
        setRandomStartDirection()
    }
    
    // Picks a random direction for the ball when starting from center
    func setRandomStartDirection()
    {
        // TODO Generate random fraction of a circle here
        let angle = 2 * Double.pi //* randomly generated fraction
        velocity = CGPoint.initWithVelocity(inDirection: angle, withSpeed: speed)
    }
    
    // Bounces ball off a horizontal barrier
    func bounceX()
    {
        velocity.x = -velocity.x
    }
    
    // Bounces ball off a vertical barrier
    func bounceY()
    {
        velocity.y = -velocity.y
    }
}

class Paddle
{
    var shape: SKShapeNode
    var position: CGPoint
    var paddleX: CGFloat
    
    let speed = 400

    init (player: Int, screenSize: CGSize)
    {
        let width = screenSize.width
        let midHeight = screenSize.height / 2
        
        // Set position to center of screen and velocity to 0
        if player == 1
        {
            paddleX = 150
        } else {
            paddleX = width - 150
        }
        position = CGPoint(x: paddleX,
                           y: midHeight)
        
        // Initialize white square
        shape = SKShapeNode(rectOf: CGSize(width: 50, height: 200))
        self.updatePosition()
        shape.fillColor = UIColor.darkGray
    }
    
    // Function to reduce errors by making 1 place and 1 place only to update the shape's position.
    func updatePosition()
    {
        shape.position = position
    }
    
    func moveTo(_ position: CGPoint)
    {
        self.position = CGPoint(x: paddleX,
                                y: position.y)
        self.updatePosition()
    }
}
