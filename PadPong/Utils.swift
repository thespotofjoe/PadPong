//
//  Utils.swift
//  PadPong
//
//  Created by Joseph Buchoff on 8/30/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import Foundation
import SpriteKit

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
    private let shape: SKShapeNode
    let size: Int
    
    var velocity: CGPoint = CGPoint.zero
    var position: CGPoint
    var leftX: CGFloat
    var rightX: CGFloat
    var topY: CGFloat
    var bottomY: CGFloat
    
    let speed = 500

    init (size: Int)
    {
        self.size = size
        
        // Set position to center of screen
        position = CGPoint.zero
        
        // Initialize white square
        shape = SKShapeNode(rectOf: CGSize(width: size, height: size))
        shape.position = position
        leftX = position.x - CGFloat(size)/2
        rightX = position.x + CGFloat(size)/2
        topY = position.y + CGFloat(size)/2
        bottomY = position.y - CGFloat(size)/2
        shape.fillColor = UIColor.white
        
        // Get everything up and running - velocity in random direction.
        reset()
    }
    
    // Function to reduce errors by making 1 place and 1 place only to update the shape's position.
    private func updatePosition(_ newPosition: CGPoint)
    {
        //print("In ball.updatePosition().\nOld Position: \(position)\nNew position: \(newPosition)")
        self.position = newPosition
        shape.position = newPosition
        leftX = newPosition.x - CGFloat(size)/2
        rightX = newPosition.x + CGFloat(size)/2
        topY = newPosition.y + CGFloat(size)/2
        bottomY = newPosition.y - CGFloat(size)/2
    }
    
    func addToView(_ scene: GameScene)
    {
        scene.addChild(shape)
    }
    
    func move(dt: CGFloat)
    {
        //print("In ball.move() about to move.\nVelocity: \(velocity)\nVelocity * dt: \(velocity * dt)")
        self.updatePosition(position + velocity * dt)
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
        let randomSide = Bool.random()
        let randomAngle = Double.random(in: Double.pi/6...5*Double.pi/6)
        
        let finalAngle = Double.pi / 2 + (randomSide ? 1 : -1) * randomAngle
        //print("finalAngle in degrees: \(finalAngle * 180 / Double.pi)")
        velocity = CGPoint.initWithVelocity(inDirection: finalAngle, withSpeed: speed)
    }
    
    // Bounces ball off a horizontal barrier
    func bounceOffVertical()
    {
        velocity.x = -velocity.x
    }
    
    // Bounces ball off a vertical barrier
    func bounceOffHorizontal()
    {
        velocity.y = -velocity.y
    }
    
    func isOutOfYBounds(maxHeight: CGFloat) -> Bool
    {
        if topY > maxHeight/2
        {
            print ("Ball hit top bounds. Center y: \(position.y)\nTopY: \(topY). Should be > \(maxHeight/2)")
            return true
        }
        
        if bottomY < -maxHeight/2
        {
            print ("Ball hit bottom bounds. Center y: \(position.y)\nBottomY: \(bottomY). Should be , -\(maxHeight/2)")
            return true
        }
        return false
    }
}
