//
//  MALWall.swift
//  GoNinja
//
//  Created by uicsi8 on 3/8/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class MALGround: SKSpriteNode {
    
    let groundHeightFactor:CGFloat = 0.1
    let groundWidthFactor:CGFloat = 2.0
    
    override init()
    {
        let groundWidth:CGFloat = frameSize.width * groundWidthFactor
        let groundHeight:CGFloat = frameSize.height * groundHeightFactor
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(groundWidth, groundHeight))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start()
    {
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: 1.0)
        let resetPosition = SKAction.moveToX(0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft,resetPosition])
        
        runAction(SKAction.repeatActionForever(moveSequence))
    }


}
