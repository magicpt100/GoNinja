//
//  Coin.swift
//  GoNinja
//
//  Created by Alexander Lenth on 3/29/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: SKSpriteNode
{
    var theCoin: SKShapeNode!
    
    override init()
    {
        
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(25, 25))
        
        var coinShape = UIBezierPath(ovalInRect: CGRect(x: -5, y: self.frame.size.height/2, width: 25, height: 25))
        
        theCoin = SKShapeNode(path: coinShape.CGPath)
        theCoin.strokeColor = UIColor.blackColor()
        theCoin.fillColor = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 0, alpha: 1.0)
        theCoin.position.x = -8
        theCoin.position.y = -25
        addChild(theCoin)
        
        var coinPB = SKPhysicsBody(rectangleOfSize: self.frame.size)

        coinPB.dynamic = false
        coinPB.allowsRotation = false
        coinPB.categoryBitMask = BodyType.coin.rawValue
        self.physicsBody = coinPB
                
        startMoving()
        
    }
    
    func startMoving()
    {
        let move = SKAction.moveByX(-frameSize.width, y: 0, duration: 2)
        runAction(SKAction.repeatActionForever(move))
    }
    
    func stopMoving()
    {
        self.removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
