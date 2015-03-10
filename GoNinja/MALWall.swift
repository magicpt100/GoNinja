//
//  MALWall.swift
//  GoNinja
//
//  Created by uicsi8 on 3/9/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class MALWall: SKSpriteNode{
    
    let wallColor = UIColor.blackColor()
    let wallWidthFactor:CGFloat = 0.1
    let wallHeightFactor:CGFloat = 0.1
    
    override init()
    {
        let wallWidth:CGFloat = frameSize.width * wallWidthFactor
        let wallHeight:CGFloat = frameSize.height * wallHeightFactor
        super.init(texture:nil, color: wallColor, size: CGSizeMake(wallWidth, wallHeight))
        startMoving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving()
    {
        let moveLeft = SKAction.moveByX(-300, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }

    
}
