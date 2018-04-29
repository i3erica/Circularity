//
//  GameScene.swift
//  Circularity
//
//  Created by Brian  on 4/29/18.
//  Copyright © 2018 Brian Abbondanza. All rights reserved.
//  This first iOS application, Dedicated to my Emma. 

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var lock = SKShapeNode()
    var path = UIBezierPath()
    var cursor = SKShapeNode()
    
    
    let zeroAngle: CGFloat = 0.0
    
    var didStart = false
    
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
        
        cursor = SKShapeNode(rectOf: CGSize(width: 40.0 - 7.0, height: 7.0), cornerRadius: 3.5)
        cursor.fillColor = SKColor.purple
        cursor.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 120.0)
        cursor.zRotation = 3.14 / 2
        cursor.zPosition = 2.0
        self.addChild(cursor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // called to init touches//
        if !didStart {
            firstRotation()
            didStart = true
        }
    }
    
    func firstRotation() {
        let dx = cursor.position.x - self.frame.width / 2
        let dy = cursor.position.y - self.frame.height / 2
        
        let radial = atan2(dy, dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: radial, endAngle: radial + CGFloat(Double.pi * 2), clockwise: true)
        let start = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 100)
        cursor.run(SKAction.repeatForever(start).reversed())
    }

    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
