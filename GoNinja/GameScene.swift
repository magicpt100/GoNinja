//
//  GameScene.swift
//  GoNinja
//
//  Created by uicsi8 on 3/6/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var groundTop: MALGround!
    var groundBot: MALGround!
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Set the background
        backgroundColor = UIColor(red: 0.54, green: 0.7853, blue: 1.0, alpha: 1.0)
        
        // Add the ground
        groundTop = MALGround(size: CGSizeMake(view.frame.width, view.frame.height/10))
        groundTop.position = CGPointMake(0, view.frame.height - groundTop.frame.size.height/2)
        println(view.frame.height)
        groundBot = MALGround(size: CGSizeMake(view.frame.width, view.frame.height/10))
        groundBot.position = CGPointMake(0, groundBot.frame.size.height/2)
        addChild(groundTop)
        addChild(groundBot)

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
