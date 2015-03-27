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
    
    var onGround: Bool!
    
    override init ()
    {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(40, 25))
        let clothesColor = UIColor(red: 36.0/255.0, green: 33.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        
        onGround = true
        
        // Add the body
        
        body = SKShapeNode(rect: CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(40, 25)), cornerRadius: 1.0)
        body.strokeColor = UIColor.blackColor()
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
        leftFoot.strokeColor = UIColor.blackColor()
        leftFoot.fillColor = clothesColor
        leftFoot.position = CGPointMake(leftFoot.frame.size.width, leftFoot.frame.size.height/2)
        leftFoot.zPosition = -1
        body.addChild(leftFoot)
        
        //Add right foot
        
        rightFoot = leftFoot.copy() as SKShapeNode
        rightFoot.position = CGPointMake(self.frame.size.width + rightFoot.frame.size.width/2-0.5, rightFoot.frame.size.height/2)
        body.addChild(rightFoot)
        
        //Add left arm
        
        leftArm = leftFoot.copy() as SKShapeNode
        leftArm.zRotation = CGFloat(-M_PI / 4.0)
        leftArm.position = CGPointMake(leftFoot.frame.size.width, 18)
        body.addChild(leftArm)
        
        //Add right arm
        
        rightArm = rightFoot.copy() as SKShapeNode
        rightArm.zRotation = CGFloat(M_PI / 4.0)
        rightArm.position = CGPointMake(rightFoot.position.x - 9.5, 38.5)
        body.addChild(rightArm)
        
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
        
    }
    
    func startRunning()
    {
        performOneRunCycle()
    }
    
    func performOneRunCycle()
    {
        let up = SKAction.moveByX(0, y: 2, duration: 0.05)
        let down = SKAction.moveByX(0, y: -2, duration: 0.05)
        
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
    func stop()
    {
        body.removeAllActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
