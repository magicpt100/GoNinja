//
//  MALMonster.swift
//  GoNinja
//
//  Created by uicsi8 on 3/29/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class MALMonster: SKSpriteNode {
    var rightEye:SKSpriteNode!
    var leftEye:SKSpriteNode!
    var mouth:SKSpriteNode!
    var leftTooth:SKSpriteNode!
    var rightTooth:SKSpriteNode!
    
    var direction = 1.0
    
    init(topOrBot: Int){
        //Body
        let bodyColor = UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        super.init(texture: nil, color: bodyColor, size: CGSizeMake(40, 40))
        
        //upper Cover
        let bodyUpperCover = SKSpriteNode(color: bodyColor, size: CGSizeMake(40, 25))
        bodyUpperCover.position = CGPointMake(0, 7.5)
        bodyUpperCover.zPosition = 1
        addChild(bodyUpperCover)
        
        //Right Eye
        rightEye = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(6, 6))
        rightEye.position = CGPointMake(13, 8)
        rightEye.zPosition = 2
        addChild(rightEye)
        
        //left Eye
        leftEye = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(6, 6))
        leftEye.position = CGPointMake(-3, 8)
        leftEye.zPosition = 2
        addChild(leftEye)
        
        //mouth
        mouth = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(24, 15))
        mouth.position = CGPointMake(8, -12.5)
        addChild(mouth)
        
        //left Tooth
        leftTooth = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(6, 12))
        leftTooth.position = CGPointMake(-3.5, 1.5)
        mouth.addChild(leftTooth)
        
        //right Tooth
        rightTooth = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(6, 12))
        rightTooth.position = CGPointMake(3.5, 1.5)
        mouth.addChild(rightTooth)
        
        // physics body
        
        let monsterPhysicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        monsterPhysicsBody.categoryBitMask = BodyType.monster.rawValue
        monsterPhysicsBody.dynamic = true
        monsterPhysicsBody.contactTestBitMask = BodyType.wall.rawValue | BodyType.hero.rawValue
        monsterPhysicsBody.collisionBitMask = BodyType.wall.rawValue
        monsterPhysicsBody.allowsRotation = false
        monsterPhysicsBody.affectedByGravity = false
        self.physicsBody = monsterPhysicsBody
        
        //Cases where monster are generated at the top
        if topOrBot == 1
        {
            self.runAction(SKAction.rotateByAngle(CGFloat(M_PI), duration: 0.1))
            direction *= -1
        }
        animateTeeth()
        walk()
        changeFace()
    }
    
    func animateTeeth()
    {
        let teethUpAction = SKAction.moveByX(0, y: 12, duration: 0.1)
        let teethDownAction = SKAction.moveByX(0, y: -12, duration: 0.1)
        let teethAnimation = SKAction.sequence([teethUpAction,SKAction.waitForDuration(1),teethDownAction,SKAction.waitForDuration(1)])
        rightTooth.runAction(SKAction.repeatActionForever(teethAnimation))
        leftTooth.runAction(SKAction.repeatActionForever(teethAnimation))
    }
    
    func walk()
    {
        let upForward = SKAction.moveByX(CGFloat(5 * direction), y: 5, duration: 0.1)
        let downForward = SKAction.moveByX(CGFloat(5 * direction), y: -5, duration: 0.1)
        let walkAnimation = SKAction.sequence([upForward,downForward])
        self.runAction(SKAction.repeatActionForever(walkAnimation))
    }
    
    func resetWalk()
    {
        self.removeAllActions()
        if direction > 0
        {
            walk()
        }
        else
        {
            walk()
            self.runAction(SKAction.repeatActionForever(SKAction.moveByX(-frameSize.width, y: 0, duration: 2)))
        }
        changeFace()
    }
    
    
    func changeFace()
    {
        rightEye.position = CGPointMake(CGFloat(13 * direction), 8)
        leftEye.position = CGPointMake(CGFloat(3 * -direction), 8)
        mouth.position = CGPointMake(CGFloat(8 * direction), -12.5)
    }
    
    func die()
    {
        self.physicsBody?.applyImpulse(CGVectorMake(30, 0))
        self.physicsBody?.affectedByGravity = true
    }
    
    func stop()
    {
        self.removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
