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
    var dot = SKShapeNode()
    var actionRed = UIColor.red
    
    
    let zeroAngle: CGFloat = 0.0
    
    var didStart = false
    var clockWise = Bool()
    
    var touched = false
    
    var gLevel = 1
    var dots = 0
    
    var gLevelLabel = SKLabelNode()
    var currentScoreLabel = SKLabelNode()
    
    
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
        
        gLevelLabel = SKLabelNode( fontNamed: "AvenirNext")
        gLevelLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + self.frame.height/3)
        gLevelLabel.fontColor = SKColor.cyan
        gLevelLabel.text = "Level \(gLevel)"
        
        currentScoreLabel = SKLabelNode( fontNamed: "AvenirNext")
        currentScoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        currentScoreLabel.fontColor = SKColor.cyan
        currentScoreLabel.text = "Begin"
        
        
        self.addChild(gLevelLabel)
        self.addChild(currentScoreLabel)
        
        newDot()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // called to init touches//
        if !didStart {
            currentScoreLabel.text = "\(gLevel - dots)"
            firstRotation()
            didStart = true
            clockWise = true
            } else{
            dotWasTouched()
            }
        
    }
    
    func firstRotation() {
        let dx = cursor.position.x - self.frame.width / 2
        let dy = cursor.position.y - self.frame.height / 2
        
        let radial = atan2(dy, dx)
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: radial, endAngle: radial + CGFloat(Double.pi * 2), clockwise: true)
        let start = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 150)
        cursor.run(SKAction.repeatForever(start).reversed())
    }
    
    func runCounterRotation() {
        let dx = cursor.position.x - self.frame.width / 2
        let dy = cursor.position.y - self.frame.height / 2
        
        let radial = atan2(dy, dx)
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: radial, endAngle: radial + CGFloat(Double.pi * 2), clockwise: true)
        let start = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 150)
        cursor.run(SKAction.repeatForever(start))
        
    }
    
    
    func dotWasTouched() {
        if touched == true {
            touched = false
            dots += 1
            updateGLabel()
            if dots >= gLevel {
                didStart = false
                completed()
                return
            }
            dot.removeFromParent()
            newDot()
            if clockWise {
                runCounterRotation()
                clockWise = false
            } else {
                firstRotation()
                clockWise = true
            }
                
        } else {
            didStart = false
            touched = false
            gameIsOver()
            
        }
    }
    
    func updateGLabel() {
        currentScoreLabel.text = "\(gLevel - dots)"
        
        
    }
    func newDot() {
        dot = SKShapeNode(circleOfRadius: 15.0)
        dot.fillColor = SKColor.purple
        dot.strokeColor = SKColor.cyan
        
        let dx = cursor.position.x - self.frame.width / 2
        let dy = cursor.position.y - self.frame.height / 2
        
        let radial = atan2(dy, dx)
        
        let startTempAngle = CGFloat.random(min: radial - 1.0, max: radial - 2.5)
        let startTempPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: startTempAngle, endAngle: startTempAngle + CGFloat(Double.pi * 2), clockwise: true)
        
        dot.position = startTempPath.currentPoint
        
        self.addChild(dot)
    }
    
    func completed() {
        cursor.removeFromParent()
        currentScoreLabel.text = "Great Work!!"
        let actionRed = SKAction.colorize(with: UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0), colorBlendFactor: 1.0, duration: 0.25)
        let actionBack = SKAction.wait(forDuration: 0.5)
        self.scene?.run(SKAction.sequence([actionRed,actionBack]), completion: { () -> Void in
            self.removeAllChildren()
            self.clockWise = false
            self.dots = 0
            self.gLevel += 1
            self.layoutGame()
        })
    }
    
    func gameIsOver() {
        cursor.removeFromParent()
        currentScoreLabel.text = "Try Again"
        let actionRed = SKAction.colorize(with: UIColor(red: 149.0/255.0, green: 165.0/255.0, blue: 166.0/255.0, alpha: 1.0), colorBlendFactor: 1.0, duration: 0.25)
        let actionBack = SKAction.wait(forDuration: 0.75)
        self.scene?.run(SKAction.sequence([actionRed,actionBack]), completion: { () -> Void in
            self.removeAllChildren()
            self.clockWise = false
            self.dots = 0
            self.layoutGame()
        })
    }

    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
