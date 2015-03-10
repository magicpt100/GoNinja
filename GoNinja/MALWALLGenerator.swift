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
    
    var generationTimer: NSTimer?
    
    func startGeneratingWalls(seconds: NSTimeInterval)
    {
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
    }
    
    func generateWall()
    {
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        if rand == 0
        {
            scale = -1.0
        }
        else
        {
            scale = 1.0
        }
        let wall = MALWall()
        wall.position.x = frameSize.width/2 + wall.size.width/2
        wall.position.y = scale * (100 + wall.size.height/2)
        addChild(wall)
    }

}