//
//  PowerUpGenerator.swift
//  GoNinja
//
//  Created by uicsi8 on 4/11/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class PowerUpGenerator:SKSpriteNode{
    
    
    func startGeneratingPowers()
    {
        var makePowerUpsAction = SKAction.sequence([SKAction.runBlock(generatePowerUp),SKAction.waitForDuration(5)])
        self.runAction(SKAction.repeatActionForever(makePowerUpsAction))
    }
    
    func generatePowerUp()
    {
        let rand1 = arc4random_uniform(2)
        //let rand2 = arc4random_uniform(4) + 1
        let rand2 = 4
        if rand1 == 0
        {
            return
        }
        else
        {
            var powerUp = PowerUps(type: Int(rand2))
            addChild(powerUp)
        }
    }
    
    func stop()
    {
        self.removeAllActions()
        self.removeAllChildren()
    }

}