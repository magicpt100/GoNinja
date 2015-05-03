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
    
    let numberOfSegments = 20
    //let color1 = UIColor(red: 235.0/255.0, green: 44.0/255.0, blue: 47.0/255.0, alpha: 1.0)
    //let color2 = UIColor(red: 235.0/255.0, green: 247.0/255.0, blue: 5.0/255.0, alpha: 1.0)
    let color1 = UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    let color2 = UIColor(red: 120.0/255.0, green: 195.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    let groundWidth:CGFloat = frameSize.width * groundWidthFactor
    let groundHeight:CGFloat = frameSize.height * groundHeightFactor
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize)
    {
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(groundWidth, groundHeight))
        
        anchorPoint = CGPointMake(0, 0.5)
        
        for (var i = 0; i < numberOfSegments; i++)
        {
            var segmentColor: UIColor!
            if (i % 2 == 0)
            {
                segmentColor = color1
            }
            else
            {
                segmentColor = color2
            }
            let segment = SKSpriteNode(color: segmentColor, size: CGSizeMake(self.size.width / CGFloat(numberOfSegments), self.size.height))
            segment.anchorPoint = CGPointMake(0,0.5)
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, 0)
            addChild(segment)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start()
    {
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: 2.0)
        let resetPosition = SKAction.moveToX(0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft,resetPosition])
        runAction(SKAction.repeatActionForever(moveSequence))
    }
    
    func stop()
    {
        self.removeAllActions()
    }


}
