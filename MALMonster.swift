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
    
    var direction:CGFloat = 1.0
    
    let monsterWidth = monsterWidthFactor * frameSize.width
    let monsterHeight = monsterHeightFactor * frameSize.height
    let bodyUpCoverHeight = bodyHeightFactor * frameSize.height
    let bodyUpCoverPosY = bodyUpCoverPosYFactor * frameSize.height
    let monsterRightEyeSize = monsterRightEyeSizeFactor * frameSize.width
    let monsterRightEyePosX = monsterRightEyePosXFactor * frameSize.width
    let monsterEyePosY = monsterEyePosYFactor * frameSize.height
    let monsterLeftEyePosX = monsterLeftEyePosXFactor * frameSize.width
    let mouthWidth = mouthWidthFactor * frameSize.width
    let mouthHeight = mouthHeightFactor * frameSize.height
    let mouthPosX = mouthPosXFactor * frameSize.width
    let mouthPosY = mouthPosYFactor * frameSize.height
    let toothWidth = toothWidthFactor * frameSize.width
    let toothHeight = toothHeightFactor * frameSize.height
    let toothPosY = toothPosYFactor * frameSize.height
    let toothPosX = toothPosXFactor * frameSize.width
    
    let colors = [UIColor.brownColor(),UIColor.blueColor(),UIColor.orangeColor(),UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.0/255.0, alpha: 1.0),UIColor.yellowColor(),UIColor.purpleColor()]
    
    init(topOrBot: Int){
        //Body
        var colorIndex = Int(arc4random_uniform(6))
        let bodyColor = colors[colorIndex]
        super.init(texture: nil, color: bodyColor, size: CGSizeMake(monsterWidth, monsterHeight))
        
        //upper Cover
        let bodyUpperCover = SKSpriteNode(color: bodyColor, size: CGSizeMake(monsterWidth, bodyUpCoverHeight))
        bodyUpperCover.position = CGPointMake(0, bodyUpCoverPosY)
        bodyUpperCover.zPosition = 1
        addChild(bodyUpperCover)
        
        //Right Eye
        rightEye = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(monsterRightEyeSize, monsterRightEyeSize))
        rightEye.position = CGPointMake(monsterRightEyePosX, monsterEyePosY)
        rightEye.zPosition = 2
        addChild(rightEye)
        
        //left Eye
        leftEye = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(monsterRightEyeSize, monsterRightEyeSize))
        leftEye.position = CGPointMake(monsterLeftEyePosX, monsterEyePosY)
        leftEye.zPosition = 2
        addChild(leftEye)
        
        //mouth
        mouth = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(mouthWidth, mouthHeight))
        mouth.position = CGPointMake(mouthPosX, mouthPosY)
        addChild(mouth)
        
        //left Tooth
        leftTooth = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(toothWidth, toothHeight))
        leftTooth.position = CGPointMake(-toothPosX, toothPosY)
        mouth.addChild(leftTooth)
        
        //right Tooth
        rightTooth = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(toothWidth, toothHeight))
        rightTooth.position = CGPointMake(toothPosX, toothPosY)
        mouth.addChild(rightTooth)
        
        // physics body
        
        let monsterPhysicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        monsterPhysicsBody.categoryBitMask = BodyType.monster.rawValue
        monsterPhysicsBody.dynamic = true
        monsterPhysicsBody.contactTestBitMask = BodyType.wall.rawValue | BodyType.hero.rawValue
        monsterPhysicsBody.collisionBitMask = BodyType.wall.rawValue
        monsterPhysicsBody.allowsRotation = false
        monsterPhysicsBody.affectedByGravity = false
        monsterPhysicsBody.mass = 0.0711111
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
        let teethUpAction = SKAction.moveByX(0, y: toothHeight, duration: 0.1)
        let teethDownAction = SKAction.moveByX(0, y: -toothHeight, duration: 0.1)
        let teethAnimation = SKAction.sequence([teethUpAction,SKAction.waitForDuration(1),teethDownAction,SKAction.waitForDuration(1)])
        rightTooth.runAction(SKAction.repeatActionForever(teethAnimation))
        leftTooth.runAction(SKAction.repeatActionForever(teethAnimation))
    }
    
    func walk()
    {
        let upForward = SKAction.moveByX(CGFloat(8 * direction), y: 5, duration: 0.1)
        let downForward = SKAction.moveByX(CGFloat(8 * direction), y: -5, duration: 0.1)
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
        rightEye.position = CGPointMake(monsterRightEyePosX * direction, monsterEyePosY)
        leftEye.position = CGPointMake(CGFloat(monsterLeftEyePosX * direction), monsterEyePosY)
        mouth.position = CGPointMake(CGFloat(mouthPosX * direction), mouthPosY)
    }
    
    func die()
    {
        self.physicsBody?.applyImpulse(CGVectorMake(30, 0))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = 0
    }
    
    func stop()
    {
        self.removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
