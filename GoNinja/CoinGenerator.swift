//
//  CoinGenerator.swift
//  GoNinja
//
//  Created by Alexander Lenth on 3/29/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class CoinGenerator: SKSpriteNode
{
    let coinPosX = coinPosXFactor * frameSize.width
    let coinY1 = coinY1Factor * frameSize.height
    let coinY2 = coinY2Factor * frameSize.height
    func generateCoin()
    {
        var yCoord: CGFloat;
        let rand = arc4random_uniform(2)
        
        //generate on top or bottom of screen
        if rand == 0 { yCoord = coinY1 }
        else { yCoord = coinY2 }
        
        let coin = Coin()
        coin.position.x = coinPosX
        coin.position.y = yCoord
        
        addChild(coin)
    
        
    }
    
    
    func startGeneratingCoins()
    {
        var makeWallsAction = SKAction.sequence([SKAction.runBlock(generateCoin), SKAction.waitForDuration(1.5)])
        self.runAction(SKAction.repeatActionForever(makeWallsAction))
    }
    
    func stopMoving()
    {
        self.removeAllActions()
        for x in self.children { x.stopMoving() }
    }

}