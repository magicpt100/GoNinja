//
//  MALWALLGenerator.swift
//  GoNinja
//
//  Created by uicsi8 on 3/9/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class MALWallGenerator:SKSpriteNode{
    
    /*var generationTimer: NSTimer?
    
    func startGeneratingWalls(seconds: NSTimeInterval)
    {
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
    }*/
    
    func startGeneratingWalls()
    {
        var makeWallsAction = SKAction.sequence([SKAction.runBlock(generateWall),SKAction.waitForDuration(1)])
        self.runAction(SKAction.repeatActionForever(makeWallsAction))
    }
    
    func generateWall()
    {
        var scale: CGFloat
        let rand1 = arc4random_uniform(2)
        let rand2 = arc4random_uniform(4)
        if rand1 == 0
        {
            scale = -1.0
        }
        else
        {
            scale = 1.0
        }
        let wall = MALWall(indictor: Int(rand2))
        wall.position.x = frameSize.width/2 + wall.size.width/2
        wall.position.y = scale * (frameSize.height * (0.5 - groundHeightFactor) - wall.size.height/2)
        addChild(wall)
 
        if(doublePoints)
        {
            pointsRaw += 2
        }
        else
        {
            pointsRaw += 1
        }
        
    }
    
    func stop()
    {
        self.removeAllActions()
        self.removeAllChildren()
        /*
        for child in self.children
        {
            child.stop()
        }*/
    }

}