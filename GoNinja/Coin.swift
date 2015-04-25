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
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize)
    {
        
       // super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(25, 25))

        
        let coinTexture = SKTexture(imageNamed:"goldCoin.png")
        
        super.init(texture: coinTexture, color: UIColor.clearColor(), size: CGSizeMake(30, 30))
        
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
