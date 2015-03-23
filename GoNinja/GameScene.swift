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
    var wallGenerator: MALWallGenerator!
    var hero: MALHero!
    var tapToStartLabel: SKLabelNode!
    var pointLabel: MALPointLabel!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Set the background
        backgroundColor = UIColor(red: 0.54, green: 0.7853, blue: 1.0, alpha: 1.0)
        
        // Add the ground
        groundTop = MALGround()
        groundTop.position = CGPointMake(0, view.frame.height - groundTop.frame.size.height/2)
        groundBot = MALGround()
        groundBot.position = CGPointMake(0, groundBot.frame.size.height/2)
        addChild(groundTop)
        addChild(groundBot)
        
        //Add wall generator
        wallGenerator = MALWallGenerator(color: UIColor.clearColor(), size: view.frame.size)
        wallGenerator.position = view.center
        addChild(wallGenerator)
        
        //Add hero
        hero = MALHero()
        addChild(hero)
        hero.breathe()
        
        //Add tapToStart label
        
        tapToStartLabel = SKLabelNode(text: "Tap to Start")
        tapToStartLabel.fontName = gameFont
        tapToStartLabel.fontSize = CGFloat(20.0)
        tapToStartLabel.position = CGPointMake(frameSize.width/2, frameSize.height/2)
        animationWithPulse(tapToStartLabel)
        addChild(tapToStartLabel)
        
        pointLabel = MALPointLabel(fontNamed: gameFont)
        pointLabel.position = CGPointMake(20, frameSize.height - groundTop.frame.height * 2)
        addChild(pointLabel)



    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        groundTop.start()
        groundBot.start()
        wallGenerator.startGeneratingWalls(1)
        hero.startRunning()
        tapToStartLabel.removeFromParent()
        
    }
    
    func animationWithPulse(node: SKNode){
        let fadeIn = SKAction.fadeInWithDuration(0.6)
        let fadeOut = SKAction.fadeOutWithDuration(0.6)
        let pulse = SKAction.sequence([fadeIn,fadeOut])
        node.runAction(SKAction.repeatActionForever(pulse))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
