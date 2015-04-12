//
//  MALCloudGenerator.swift
//  GoNinja
//
//  Created by uicsi8 on 4/5/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class MALCloudGenerator: SKSpriteNode
{
    let cloudWidth: CGFloat = 125.0
    let cloudHeight: CGFloat = 55.0
    
    func populate(num : Int)
    {
        for(var i = 0; i < num; i++)
        {
            let cloud = MALCloud(size: CGSizeMake(cloudWidth, cloudHeight))
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            cloud.position = CGPointMake(x, y)
            cloud.zPosition = -5
            addChild(cloud)
        }
    }
    
    func startGenerating()
    {
        let makeCloudAction = SKAction.sequence([SKAction.runBlock(generateCloud),SKAction.waitForDuration(7)])
        self.runAction(SKAction.repeatActionForever(makeCloudAction))
    }
    
    func generateCloud()
    {
        let x = size.width/2 + cloudWidth/2
        let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
        let cloud = MALCloud(size: CGSizeMake(cloudWidth, cloudHeight))
        cloud.position = CGPointMake(x, y)
        cloud.zPosition = -5
        addChild(cloud)
    }
}
