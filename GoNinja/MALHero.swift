//
//  MLHero.swift
//  Nimble Ninja
//
//  Created by uicsi8 on 2/8/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class MALHero: SKSpriteNode {
    
    var body: SKShapeNode!
    var leftArm: SKShapeNode!
    var rightArm: SKShapeNode!
    var leftFoot: SKShapeNode!
    var rightFoot: SKShapeNode!
    var head: SKShapeNode!
    var ninjaStar: SKSpriteNode!
    var ninjaSword: SKSpriteNode!
    var newStar: SKSpriteNode!
    var newSword: SKSpriteNode!
    
    var rightArmAnchorPoint: SKSpriteNode!
    var leftArmAnchorPoint: SKSpriteNode!
    
    var onGround = true
    var powerUpStatus = 0 // 0,1,2,3,4 - 0: no powerUps
    
    var starInAir = false
    
    override init ()
    {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(40, 25))
        let clothesColor = UIColor(red: 36.0/255.0, green: 33.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        onGround = true
        
        // Add the body
        
        body = SKShapeNode(rect: CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(40, 25)), cornerRadius: 1.0)
        body.strokeColor = clothesColor
        body.fillColor = clothesColor
        body.position = CGPointMake(80, 54)
        addChild(body)
        
        // Add the head
        
        var headShape = UIBezierPath(ovalInRect: CGRect(x: -5, y: self.frame.size.height/2, width: 50, height: 50))
        
        head = SKShapeNode(path: headShape.CGPath)
        head.strokeColor = UIColor.blackColor()
        head.lineWidth = 2.0
        head.fillColor = clothesColor
        body.addChild(head)
        
        
        let skinColor = UIColor(red: 207.0/255.0, green: 193.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        /*
        let faceShape = UIBezierPath()
        faceShape.moveToPoint(CGPointMake(0, 36))
        faceShape.addQuadCurveToPoint(CGPointMake(40, 36), controlPoint: CGPointMake(20,8))
        faceShape.moveToPoint(CGPointMake(40, 36))
        faceShape.addQuadCurveToPoint(CGPointMake(0,36), controlPoint: CGPointMake(20, 33))
        let face = SKShapeNode(path: faceShape.CGPath)
        face.fillColor = skinColor
        face.strokeColor = UIColor.blackColor()
        face.lineWidth = 2.0
        head.addChild(face)*/
        
        // Add the face
        
        let faceShape = CGPathCreateMutable()
        CGPathMoveToPoint(faceShape, nil, 1, 37)
        CGPathAddLineToPoint(faceShape, nil, 40, 37)
        CGPathAddArc(faceShape, nil, 20.5, 37, 19.5, CGFloat(M_PI), 0, false)
        let face = SKShapeNode(path: faceShape)
        face.fillColor = skinColor
        face.strokeColor = clothesColor
        head.addChild(face)
        
        // Add left eye

        let leftEyeShape = UIBezierPath(ovalInRect: CGRect(x: 12.5, y: 25.5, width: 4.5, height: 4.5))
        let leftEye = SKShapeNode(path: leftEyeShape.CGPath)
        leftEye.fillColor = UIColor.blackColor()
        leftEye.strokeColor = UIColor.blackColor()
        head.addChild(leftEye)
        
        // Add right eye
        
        let rightEyeShape = UIBezierPath(ovalInRect: CGRect(x: 23.5, y: 25.5, width: 4.5, height: 4.5))
        let rightEye = SKShapeNode(path: rightEyeShape.CGPath)
        rightEye.fillColor = UIColor.blackColor()
        rightEye.strokeColor = UIColor.blackColor()
        head.addChild(rightEye)
        
        // Add left eyebrow
        
        let leftEyeBrowShape = CGPathCreateMutable()
        CGPathMoveToPoint(leftEyeBrowShape, nil, 0, 0)
        CGPathAddLineToPoint(leftEyeBrowShape, nil, -8, 2)
        let leftEyeBrow = SKShapeNode(path: leftEyeBrowShape)
        leftEyeBrow.strokeColor = UIColor.blackColor()
        leftEyeBrow.lineWidth = 1.5
        leftEyeBrow.position = CGPointMake(18, 32.5)
        head.addChild(leftEyeBrow)
        
        //Add right eyebrow
        
        let rightEyeBrowShape = CGPathCreateMutable()
        CGPathMoveToPoint(rightEyeBrowShape, nil, 0, 0)
        CGPathAddLineToPoint(rightEyeBrowShape, nil, 8, 2)
        let rightEyeBrow = SKShapeNode(path: rightEyeBrowShape)
        rightEyeBrow.strokeColor = UIColor.blackColor()
        rightEyeBrow.lineWidth = 1.5
        rightEyeBrow.position = CGPointMake(22.5, 32.5)
        head.addChild(rightEyeBrow)
        
        //Add left foot
        
        var leftFootShape = CGPathCreateMutable()
        CGPathMoveToPoint(leftFootShape, nil, -self.frame.size.width/2, -self.frame.size.height/2)
        CGPathAddLineToPoint(leftFootShape, nil, -self.frame.size.width/2, -self.frame.size.height/2 - 12)
        CGPathAddArc(leftFootShape, nil, -self.frame.size.width/2 + 5, -self.frame.size.height/2 - 12, 5, CGFloat(M_PI),CGFloat(0),false)
        CGPathAddLineToPoint(leftFootShape, nil, -self.frame.size.width/2 + 10, -self.frame.size.height/2 - 12)
        CGPathAddLineToPoint(leftFootShape, nil, -self.frame.size.width/2 + 10, -self.frame.size.height/2)
        CGPathAddLineToPoint(leftFootShape, nil, -self.frame.size.width/2, -self.frame.size.height/2)
        leftFoot = SKShapeNode(path:leftFootShape)
        leftFoot.strokeColor = clothesColor
        leftFoot.fillColor = clothesColor
        leftFoot.position = CGPointMake(leftFoot.frame.size.width, leftFoot.frame.size.height/2)
        leftFoot.zPosition = -1
        body.addChild(leftFoot)
        
        //Add right foot
        
        rightFoot = leftFoot.copy() as SKShapeNode
        rightFoot.position = CGPointMake(self.frame.size.width + rightFoot.frame.size.width/2-0.5, rightFoot.frame.size.height/2)
        body.addChild(rightFoot)
        
        //Add left arm
        
        leftArmAnchorPoint = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(3, 3))
        leftArmAnchorPoint.position = CGPointMake(0, 20)
        body.addChild(leftArmAnchorPoint)
        
        leftArm = leftFoot.copy() as SKShapeNode
        leftArm.zRotation = CGFloat(-M_PI / 4.0)
        //leftArm.position = CGPointMake(leftFoot.frame.size.width, 18)
        leftArm.position = CGPointMake(20, 0)
        leftArmAnchorPoint.addChild(leftArm)
        
        //Add right arm
        
        rightArmAnchorPoint = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(3, 3))
        rightArmAnchorPoint.position = CGPointMake(40, 20)
        body.addChild(rightArmAnchorPoint)
        
        rightArm = rightFoot.copy() as SKShapeNode
        rightArm.zRotation = CGFloat(M_PI / 4.0)
        //rightArm.position = CGPointMake(rightFoot.position.x - 9.5, 38.5)
        rightArm.position = CGPointMake(0, 20)
        rightArmAnchorPoint.addChild(rightArm)
        //Add ninja star
        
        ninjaStar = SKSpriteNode(imageNamed: "ninjaStar")
        ninjaStar.size = CGSizeMake(20, 20)
        ninjaStar.position = CGPointMake(53, 5)
        body.addChild(ninjaStar)
        
        // Add ninja Sword
        
        ninjaSword = SKSpriteNode(imageNamed: "ninjaSword")
        ninjaSword.size = CGSizeMake(50, 40)
        ninjaSword.zPosition = -2
        ninjaSword.zRotation = CGFloat(-M_PI/2)
        ninjaSword.position = CGPointMake(0, 25)
        body.addChild(ninjaSword)

        //Add physics for collision and contact detection
        var heroBodyPhysicsBody = SKPhysicsBody(rectangleOfSize:CGSize(width: 70,height: 78), center: CGPointMake(23, 24))
        heroBodyPhysicsBody.dynamic = true
        heroBodyPhysicsBody.allowsRotation = false
        heroBodyPhysicsBody.affectedByGravity = false
        heroBodyPhysicsBody.categoryBitMask = BodyType.hero.rawValue
        heroBodyPhysicsBody.collisionBitMask = 0
        heroBodyPhysicsBody.contactTestBitMask = BodyType.wall.rawValue ^ BodyType.coin.rawValue
        body.physicsBody = heroBodyPhysicsBody
        
        
        //Add the new star
        newStar = SKSpriteNode(imageNamed: "powerUp3")
        newStar.size = CGSizeMake(30, 30)
        newStar.position = CGPointMake(55, 13)
        newStar.physicsBody = SKPhysicsBody(rectangleOfSize: newStar!.size)
        newStar.physicsBody!.affectedByGravity = false
        newStar.physicsBody!.allowsRotation = true
        newStar.physicsBody!.categoryBitMask = 0
        newStar.physicsBody!.collisionBitMask = 0
        newStar.physicsBody!.linearDamping = 0.5
        newStar.physicsBody!.dynamic = true
        newStar.physicsBody!.contactTestBitMask = BodyType.wall.rawValue | BodyType.monster.rawValue
        body.addChild(newStar)
        newStar.hidden = true
        
        //Add the new Sword
        newSword = SKSpriteNode(imageNamed: "newSword")
        newSword.size = CGSizeMake(50, 40)
        newSword.zPosition = -2
        rightArmAnchorPoint.addChild(newSword)
        newSword.position = CGPointMake(18, 16)
        newSword.zRotation = CGFloat(M_PI_4 * 0.6)
        newSword.zPosition = 1
        newSword.hidden = true

        
    }
    
    func startRunning()
    {
        performOneRunCycle()
    }
    
    func performOneRunCycle()
    {
        let up = SKAction.moveByX(0, y: 3, duration: 0.05)
        let down = SKAction.moveByX(0, y: -3, duration: 0.05)

        leftFoot.runAction(up, completion: { () -> Void in
            self.leftFoot.runAction(down)
            self.rightFoot.runAction(up, completion: { () -> Void in
                self.rightFoot.runAction(down, completion: { () -> Void in
                    self.performOneRunCycle()
                })
            })
        })
    }
    
    
    func breathe()
    {
        let breathOut = SKAction.moveByX(0, y:-2, duration: 1)
        let breathIn = SKAction.moveByX(0, y: 2, duration: 1)
        let breath = SKAction.sequence([breathOut,breathIn])
        body.runAction(SKAction.repeatActionForever(breath))
        
    }
    
    func receivePowerUp(powerUpType: Int)
    {
        switch powerUpType {
        case 1:
            powerUpStatus = 1
            ninjaSword.hidden = true
            newSword.hidden = false
            ninjaStar.alpha = 0
        case 2:
            powerUpStatus = 2
            self.alpha = 0.7
            self.body.physicsBody!.contactTestBitMask = BodyType.coin.rawValue
        case 3:
            powerUpStatus = 3
            ninjaStar.hidden = true
            ninjaSword.hidden = true
            newStar.hidden = false
            newStar.physicsBody!.categoryBitMask = BodyType.ninjaStar.rawValue
            newStar.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(M_PI), duration: 0.1)))
        default:
            powerUpStatus = 0
        }
    }
    
    func removePowerUpEffect()
    {
        switch powerUpStatus{
        case 1:
            powerUpStatus = 0
            ninjaSword.hidden = false
            newSword.hidden = true
            ninjaStar.alpha = 1.0
        case 2:
            powerUpStatus = 0
            self.alpha = 1.0
            self.body.physicsBody!.contactTestBitMask = BodyType.wall.rawValue ^ BodyType.coin.rawValue
        case 3:
            powerUpStatus = 0
            ninjaSword.hidden = false
            ninjaStar.hidden = false
            newStar.hidden = true
            newStar.physicsBody!.categoryBitMask = 0
        default:
            powerUpStatus = 0
        }
    }
    
    func swingSword()
    {
        var upSwing = SKAction.rotateToAngle(CGFloat(M_PI_4), duration: 0.1)
        var downSwing = SKAction.rotateToAngle(CGFloat(-M_PI_4 * 0.6), duration: 0.2)
        var restore = SKAction.rotateToAngle(0, duration: 0.0)
        var swing = SKAction.sequence([upSwing,downSwing,restore])
        rightArmAnchorPoint.runAction(swing)
    }
    
    func throwNinjaStar()
    {
        if (!starInAir)
        {
            var upSwing = SKAction.rotateToAngle(CGFloat(M_PI_4), duration: 0.1)
            var downSwing = SKAction.rotateToAngle(CGFloat(-M_PI_4 * 0.6), duration: 0.2)
            var restore = SKAction.rotateToAngle(0, duration: 0.0)
            var swing = SKAction.sequence([upSwing,downSwing,restore])
            rightArmAnchorPoint.runAction(SKAction.sequence([swing,restore]))
            if onGround
            {
                newStar.physicsBody!.applyImpulse(CGVectorMake(20, 12))
                newStar.physicsBody!.affectedByGravity = true
            }
            else
            {
                newStar.physicsBody!.applyImpulse(CGVectorMake(20, -12))
            }
            starInAir = true
        }
    }
    
    func restoreStar()
    {
        newStar.physicsBody!.affectedByGravity = false
        newStar.physicsBody!.velocity = CGVectorMake(0, 0)
        newStar.position = CGPointMake(55, 13)
        starInAir = false
    }
    
    func fall(){
        var direction = 1
        if !onGround
        {
            direction = -1
        }
        var upVector = CGFloat(30 * direction)
        body.physicsBody?.affectedByGravity = true
        body.physicsBody?.applyImpulse(CGVectorMake(-5, upVector))
        let rotateBack = SKAction.rotateByAngle(CGFloat(M_PI)/CGFloat(direction * 2), duration: 0.4)
        runAction(rotateBack)
    }
    
    
    func stop()
    {
        body.removeAllActions()
        leftFoot.removeAllActions()
        rightFoot.removeAllActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
