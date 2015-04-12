//
//  PowerUPOfPenetration.swift
//  GoNinja
//
//  Created by uicsi8 on 4/6/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class PowerUps: SKSpriteNode {
    
    var type:Int
    let textureArray = ["powerUp1","powerUp2"]
    init(type:Int)
    {
        self.type = type
        let powerUpTexture = SKTexture(imageNamed: textureArray[type-1])
        super.init(texture: powerUpTexture, color: UIColor.yellowColor(), size: CGSizeMake(40, 40))
        self.position = CGPointMake(300, 300)
        var powerUpPhysicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        powerUpPhysicsBody.categoryBitMask = BodyType.power_ups.rawValue
        powerUpPhysicsBody.collisionBitMask = 0
        powerUpPhysicsBody.contactTestBitMask = BodyType.hero.rawValue
        powerUpPhysicsBody.allowsRotation = false
        powerUpPhysicsBody.affectedByGravity  = false
        powerUpPhysicsBody.dynamic = false
        self.physicsBody = powerUpPhysicsBody
        startMoving()
    }
    
    func startMoving()
    {
        let moveLeft = SKAction.moveByX(-frameSize.width, y: 0, duration: 10)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    func getType() -> Int
    {
        return type
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
