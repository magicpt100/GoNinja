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
    var clothesColor = UIColor(red: 36.0/255.0, green: 33.0/255.0, blue: 30.0/255.0, alpha: 1.0)

    override init(texture: SKTexture!, color: UIColor!, size: CGSize)
    {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(40, 25))
        onGround = true
        
        // Add the body
        
        body = SKShapeNode(rect: CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(bodyWidth, bodyHeight)), cornerRadius: 1.0)
        body.strokeColor = clothesColor
        body.fillColor = clothesColor
        body.position = CGPointMake(heroPositionX, heroPositionY)
        addChild(body)
        
        // Add the head
        
        var headShape = UIBezierPath(ovalInRect: CGRect(x: headPosition, y: self.frame.size.height/2, width: headWidth, height: headHeight))
        
        head = SKShapeNode(path: headShape.CGPath)
        head.strokeColor = UIColor.blackColor()
        head.lineWidth = 2.0
        head.fillColor = clothesColor
        body.addChild(head)
        
        
        let skinColor = UIColor(red: 207.0/255.0, green: 193.0/255.0, blue: 168.0/255.0, alpha: 1.0)

        
        // Add the face
        
        let faceShape = CGPathCreateMutable()
        CGPathMoveToPoint(faceShape, nil, faceStart, faceY)
        CGPathAddLineToPoint(faceShape, nil, faceEnd, faceY)
        CGPathAddArc(faceShape, nil, (faceStart+faceEnd)/2.0, faceY, (faceEnd-faceStart)/2.0, CGFloat(M_PI), 0, false)
        let face = SKShapeNode(path: faceShape)
        face.fillColor = skinColor
        face.strokeColor = clothesColor
        head.addChild(face)
        
        // Add left eye

        let leftEyeShape = UIBezierPath(ovalInRect: CGRect(x: leftEyeX, y: eyeY, width: eyeSizeX, height: eyeSizeY))
        let leftEye = SKShapeNode(path: leftEyeShape.CGPath)
        leftEye.fillColor = UIColor.blackColor()
        leftEye.strokeColor = UIColor.blackColor()
        head.addChild(leftEye)
        
        // Add right eye
        
        let rightEyeShape = UIBezierPath(ovalInRect: CGRect(x: rightEyeX, y: eyeY, width: eyeSizeX, height: eyeSizeY))
        let rightEye = SKShapeNode(path: rightEyeShape.CGPath)
        rightEye.fillColor = UIColor.blackColor()
        rightEye.strokeColor = UIColor.blackColor()
        head.addChild(rightEye)
        
        // Add left eyebrow
        
        let leftEyeBrowShape = CGPathCreateMutable()
        CGPathMoveToPoint(leftEyeBrowShape, nil, 0, 0)
        CGPathAddLineToPoint(leftEyeBrowShape, nil, leftEyeBrowX, leftEyeBrowY)
        let leftEyeBrow = SKShapeNode(path: leftEyeBrowShape)
        leftEyeBrow.strokeColor = UIColor.blackColor()
        leftEyeBrow.lineWidth = 1.5
        leftEyeBrow.position = CGPointMake(leftEyeBrowPosX, eyeBrowPosY)
        head.addChild(leftEyeBrow)
        
        //Add right eyebrow
        
        let rightEyeBrowShape = CGPathCreateMutable()
        CGPathMoveToPoint(rightEyeBrowShape, nil, 0, 0)
        CGPathAddLineToPoint(rightEyeBrowShape, nil, -leftEyeBrowX, leftEyeBrowY)
        let rightEyeBrow = SKShapeNode(path: rightEyeBrowShape)
        rightEyeBrow.strokeColor = UIColor.blackColor()
        rightEyeBrow.lineWidth = 1.5
        rightEyeBrow.position = CGPointMake(rightEyeBrowPosX, eyeBrowPosY)
        head.addChild(rightEyeBrow)
        
        //Add left foot
        
        var leftFootShape = CGPathCreateMutable()
        CGPathMoveToPoint(leftFootShape, nil, -self.frame.size.width/2, -self.frame.size.height/2)
        CGPathAddLineToPoint(leftFootShape, nil, -self.frame.size.width/2, -self.frame.size.height/2 - footHeight)
        CGPathAddArc(leftFootShape, nil, -self.frame.size.width/2 + footWidth, -self.frame.size.height/2 - footHeight, footWidth, CGFloat(M_PI),CGFloat(0),false)
        CGPathAddLineToPoint(leftFootShape, nil, -self.frame.size.width/2 + footWidth*2, -self.frame.size.height/2 - footHeight)
        CGPathAddLineToPoint(leftFootShape, nil, -self.frame.size.width/2 + footWidth*2, -self.frame.size.height/2)
        leftFoot = SKShapeNode(path:leftFootShape)
        leftFoot.strokeColor = clothesColor
        leftFoot.fillColor = clothesColor
        leftFoot.position = CGPointMake(leftFoot.frame.size.width, leftFoot.frame.size.height/2)
        leftFoot.zPosition = -1
        body.addChild(leftFoot)
        
        //Add right foot
        
        rightFoot = leftFoot.copy() as! SKShapeNode
        rightFoot.position = CGPointMake(self.frame.size.width + rightFoot.frame.size.width/2-rightFootAdjustment, rightFoot.frame.size.height/2)
        body.addChild(rightFoot)
        
        //Add left arm
        
        leftArmAnchorPoint = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(anchorPointSize,anchorPointSize))
        leftArmAnchorPoint.position = CGPointMake(0, leftAnchorY)
        body.addChild(leftArmAnchorPoint)

        leftArm = leftFoot.copy() as! SKShapeNode
        leftArm.zRotation = CGFloat(-M_PI / 4.0)
        leftArm.position = CGPointMake(leftArmX, 0)
        leftArmAnchorPoint.addChild(leftArm)
        
        //Add right arm
        
        rightArmAnchorPoint = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(anchorPointSize, anchorPointSize))
        //rightArmAnchorPoint = leftArmAnchorPoint.copy() as! SKSpriteNode
        rightArmAnchorPoint.position = CGPointMake(bodyWidth, leftAnchorY)
        body.addChild(rightArmAnchorPoint)
        
        rightArm = leftFoot.copy() as! SKShapeNode
        rightArm.zRotation = CGFloat(M_PI/4)
        rightArm.position = CGPointMake(0, leftAnchorY)
        rightArmAnchorPoint.addChild(rightArm)
        //body.addChild(leftArm)
        //Add ninja star
        
        ninjaStar = SKSpriteNode(imageNamed: "ninjaStar")
        ninjaStar.size = CGSizeMake(ninjaStarSize, ninjaStarSize)
        ninjaStar.position = CGPointMake(ninjaStarPosX, ninjaStarPosY)
        body.addChild(ninjaStar)
        
        // Add ninja Sword
        
        ninjaSword = SKSpriteNode(imageNamed: "ninjaSword")
        ninjaSword.size = CGSizeMake(ninjaSwordSizeX, ninjaSwordSizeY)
        ninjaSword.zPosition = -2
        ninjaSword.zRotation = CGFloat(-M_PI/2)
        ninjaSword.position = CGPointMake(0, ninjaSwordPosY)
        body.addChild(ninjaSword)

        //Add physics for collision and contact detection
        //var heroBodyPhysicsBody = SKPhysicsBody(rectangleOfSize:CGSize(width: heroPhysicsWidth,height: heroPhysicsHeight), center: CGPointMake(heroPhysicsCenterX, heroPhysicsCenterY))
        var heroBodyPhysicsBody = SKPhysicsBody(circleOfRadius: bodyWidth, center: CGPointMake(heroPhysicsCenterX, heroPhysicsCenterY))
        heroBodyPhysicsBody.dynamic = true
        heroBodyPhysicsBody.allowsRotation = false
        heroBodyPhysicsBody.affectedByGravity = false
        heroBodyPhysicsBody.categoryBitMask = BodyType.hero.rawValue
        heroBodyPhysicsBody.collisionBitMask = 0
        heroBodyPhysicsBody.contactTestBitMask = BodyType.wall.rawValue ^ BodyType.coin.rawValue
        heroBodyPhysicsBody.mass = 0.2234
        body.physicsBody = heroBodyPhysicsBody
        
        
        //Add the new star
        newStar = SKSpriteNode(imageNamed: "powerUp3")
        newStar.size = CGSizeMake(newStarSize, newStarSize)
        newStar.position = CGPointMake(newStarPosX, newStarPosY)
        newStar.physicsBody = SKPhysicsBody(rectangleOfSize: newStar!.size)
        newStar.physicsBody!.affectedByGravity = false
        newStar.physicsBody!.allowsRotation = true
        newStar.physicsBody!.categoryBitMask = 0
        newStar.physicsBody!.collisionBitMask = 0
        newStar.physicsBody!.linearDamping = 0.5
        newStar.physicsBody!.dynamic = true
        newStar.physicsBody!.contactTestBitMask = BodyType.wall.rawValue | BodyType.monster.rawValue
        newStar.physicsBody!.mass = 0.04
        body.addChild(newStar)
        newStar.hidden = true
        
        //Add the new Sword
        newSword = SKSpriteNode(imageNamed: "newSword")
        newSword.size = CGSizeMake(ninjaSwordSizeX, ninjaSwordSizeY)
        newSword.zPosition = -2
        rightArmAnchorPoint.addChild(newSword)
        newSword.position = CGPointMake(newSwordPosX, newSwordPosY)
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
            //newStar.physicsBody!.categoryBitMask = BodyType.ninjaStar.rawValue
            newStar.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(M_PI), duration: 0.1)))
        case 4:

            let gold = UIColor(red: 255/255, green: 215/255, blue: 0, alpha: 1)
            powerUpStatus = 4
            doublePoints = true

            head.fillColor = gold
            body.fillColor = gold
            leftArm.fillColor = gold
            rightArm.fillColor = gold
            leftFoot.fillColor = gold
            rightFoot.fillColor = gold
            
            
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
        case 4:
            powerUpStatus = 0
            doublePoints = false
            head.fillColor = clothesColor
            body.fillColor = clothesColor
            leftArm.fillColor = clothesColor
            rightArm.fillColor = clothesColor
            leftFoot.fillColor = clothesColor
            rightFoot.fillColor = clothesColor
            
        default:
            powerUpStatus = 0
        }
    }
    
    func swingSword()
    {
        var upSwing = SKAction.rotateToAngle(CGFloat(M_PI_4 * 1.2), duration: 0.2)
        var downSwing = SKAction.rotateToAngle(CGFloat(-M_PI_4 * 1.0), duration: 0.2)
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
            newStar.physicsBody!.categoryBitMask = BodyType.ninjaStar.rawValue
        }
    }
    
    func restoreStar()
    {
        newStar.physicsBody!.affectedByGravity = false
        newStar.physicsBody!.velocity = CGVectorMake(0, 0)
        newStar.physicsBody!.categoryBitMask = 0
        newStar.position = CGPointMake(newStarPosX, newStarPosY)
        starInAir = false
    }
    
    func fall(){
        var direction = 1.0
        if !onGround
        {
            direction = -1.0
        }
        var upVector = 30 * CGFloat(direction)
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
    
    func throwOldStar()
    {
        var upSwing = SKAction.rotateToAngle(CGFloat(M_PI_4), duration: 0.1)
        var downSwing = SKAction.rotateToAngle(CGFloat(-M_PI_4 * 0.6), duration: 0.2)
        var restore = SKAction.rotateToAngle(0, duration: 0.0)
        var swing = SKAction.sequence([upSwing,downSwing,restore])
        rightArmAnchorPoint.runAction(SKAction.sequence([swing,restore]))
        var forward = SKAction.moveByX(frameSize.width/3, y: 0, duration: 1.0)
        var backward = SKAction.moveByX(-frameSize.width/3, y: 0, duration: 1.0)
        ninjaStar.runAction(SKAction.rotateByAngle(CGFloat(M_PI * 16), duration: 2.0))
        ninjaStar.runAction(SKAction.sequence([forward,backward]))
    }
    
    func prepareSword()
    {
        ninjaSword.removeFromParent()
        rightArmAnchorPoint.addChild(ninjaSword)
        ninjaSword.position = CGPointMake(newSwordPosX, newSwordPosY)
        ninjaSword.zRotation = CGFloat(M_PI_4 * 0.6)
        ninjaSword.zPosition = 1
        ninjaStar.hidden = true
    }
    
    func restoreSword()
    {
        ninjaStar.hidden = false
        ninjaSword.removeFromParent()
        ninjaSword.zPosition = -2
        ninjaSword.zRotation = CGFloat(-M_PI/2)
        ninjaSword.position = CGPointMake(0, ninjaSwordPosY)
        body.addChild(ninjaSword)

    }
    
    func startAnimation()
    {
        var animationSequence = SKAction.sequence([SKAction.runBlock(throwOldStar),SKAction.waitForDuration(4),SKAction.runBlock(prepareSword),SKAction.runBlock(swingSword),SKAction.waitForDuration(1.0),SKAction.runBlock(swingSword),SKAction.waitForDuration(1.0),SKAction.runBlock(restoreSword), SKAction.waitForDuration(4)])
        self.runAction(SKAction.repeatActionForever(animationSequence))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
