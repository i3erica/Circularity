//
//  GameScene.swift
//  Circularity
//
//  Created by Brian  on 4/29/18.
//  Copyright © 2018 Brian Abbondanza. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var lock = SKShapeNode()
    var path = UIBezierPath()
    
    let zeroAngle: CGFloat = 0.0
    
    override func didMove(to view: SKView) {
        layoutGame()
    }
    
    func layoutGame() {
        backgroundColor = SKColor.black
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: 120, startAngle: zeroAngle, endAngle: zeroAngle + CGFloat(Double.pi * 2), clockwise: true)
        lock = SKShapeNode(path: path.cgPath)
        lock.strokeColor = SKColor.cyan
        lock.lineWidth = 40.0
        self.addChild(lock)
    }
    
   // removed override here for touches began// 
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
