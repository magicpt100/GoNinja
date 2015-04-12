//
//  MALWall.swift
//  GoNinja
//
//  Created by uicsi8 on 3/9/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

//commit test Alex

import Foundation
import SpriteKit

class MALWall: SKSpriteNode{
    
    let wallColor = UIColor.brownColor()
    
    // the indictor indicates tall wall or low wall
    init(indictor : Int)
    {
        var wallWidth:CGFloat = frameSize.width * wallWidthFactor
        var wallHeight:CGFloat
        if (indictor == 0)
        {
            wallHeight = frameSize.height * wallHeightFactorTall
        }
        else
        {
            wallHeight = frameSize.height * wallHeightFactorLow
        }
        super.init(texture:nil, color: wallColor, size: CGSizeMake(wallWidth, wallHeight))
        var wallPhysicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        wallPhysicsBody.dynamic = false
        wallPhysicsBody.allowsRotation = false
        wallPhysicsBody.affectedByGravity = false
        wallPhysicsBody.categoryBitMask = BodyType.wall.rawValue
        self.physicsBody = wallPhysicsBody
        startMoving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving()
    {
        let moveLeft = SKAction.moveByX(-frameSize.width, y: 0, duration: 2)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    func stop()
    {
        self.removeAllActions()
    }

    
}
