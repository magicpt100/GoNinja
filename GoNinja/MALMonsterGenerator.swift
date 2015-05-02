//
//  MALMonsterGenerator.swift
//  GoNinja
//
//  Created by uicsi8 on 4/1/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class MALMonsterGenerator: SKSpriteNode {
    
    let monsterChagnePos = monsterChangePosFactor * frameSize.height
    func startGeneratingMonster()
    {
        var makeMonstersAction = SKAction.sequence([SKAction.runBlock(generateMonster),SKAction.waitForDuration(4)])
        self.runAction(SKAction.repeatActionForever(makeMonstersAction))
    }
    
    func generateMonster()
    {
        var scale: CGFloat
        let rand1 = arc4random_uniform(2)
        let rand2 = arc4random_uniform(2)
        if rand2 == 0
        {
            return
        }
        if rand1 == 0
        {
            scale = 1.0
        }
        else
        {
            scale = -1.0
        }
        let monster = MALMonster(topOrBot: Int(rand1))
        monster.position.x = frameSize.width/2 + monster.size.width/2
        monster.position.y = frameSize.height * 0.5 - scale * monsterChagnePos
        addChild(monster)
    }
    
    func stop()
    {
        self.removeAllActions()
        for child in self.children
        {
            child.stop()
        }
    }

}
