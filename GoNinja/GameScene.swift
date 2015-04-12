//
//  GameScene.swift
//  GoNinja
//
//  Created by uicsi8 on 3/6/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

//commit-push test by Alex

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var groundTop: MALGround!
    var groundBot: MALGround!
    var wallGenerator: MALWallGenerator!
    var monsterGenerator: MALMonsterGenerator!
    var hero: MALHero!
    var tapToStartLabel: SKLabelNode!
    var pointLabel: MALPointLabel!
    var isStart = false
    var isGameOver = false
    var pauseButton: UIButton!
    var cloudGenerator: MALCloudGenerator!
    var powerUpGenerator: PowerUpGenerator!
    var power: PowerUps!
    var timer: CountDownTimer?
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        generateWorld(view)

    }
    
    func pausePressed(sender:UIButton){
        self.paused = !self.paused
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        //hero.swingSword()
        //hero.throwNinjaStar()
        if !isStart
        {
            start()
        }
        if isGameOver
        {
            reStartGame()
        }
        
    }
    
    func generateWorld(view:SKView)
    {
        // Set the background
        backgroundColor = UIColor(red: 0.54, green: 0.7853, blue: 1.0, alpha: 1.0)
        
        //Set the physics
        physicsWorld.contactDelegate = self
        //physicsWorld.gravity = CGVectorMake(0, 0)
        
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
        
        
        //Add the cloud background
        cloudGenerator = MALCloudGenerator(color: UIColor.clearColor(), size: frameSize)
        cloudGenerator.position = view.center
        addChild(cloudGenerator)
        cloudGenerator.populate(5)
        cloudGenerator.startGenerating()
        
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
        
        //Add the point Label
        pointLabel = MALPointLabel(fontNamed: gameFont)
        pointLabel.position = CGPointMake(20, frameSize.height - groundTop.frame.height * 2)
        addChild(pointLabel)
        
        //Add the pause Button
        
        let pauseIcon = UIImage(named: "pauseIcon")
        pauseButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        pauseButton.frame = CGRectMake(frameSize.width - 30, 0, 27, 27)
        pauseButton.setBackgroundImage(pauseIcon, forState: UIControlState.Normal)
        pauseButton.addTarget(self, action: "pausePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(pauseButton)
        
        //Add Monster Generator
        monsterGenerator = MALMonsterGenerator()
        addChild(monsterGenerator)
        
        /*
        power = PowerUps(type:2)
        power.position = CGPointMake(300, 300)
        addChild(power)
        
        var timer = CountDownTimer(time: 10)
        timer.position = CGPointMake(300, 300)
        addChild(timer)
        */
        //Add power-Ups
        powerUpGenerator = PowerUpGenerator()
        addChild(powerUpGenerator)
        
    }
    
    
    func start(){
        isStart = true
        hero.stop()
        groundTop.start()
        groundBot.start()
        wallGenerator.startGeneratingWalls()
        hero.startRunning()
        monsterGenerator.startGeneratingMonster()
        tapToStartLabel.removeFromParent()
        powerUpGenerator.startGeneratingPowers()
    }
    
    func gameOver(){
        isGameOver = true
        var gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontName = gameFont
        gameOverLabel.position = CGPointMake(frameSize.width/2, frameSize.height/2)
        addChild(gameOverLabel)
        hero.stop()
        wallGenerator.stop()
        monsterGenerator.stop()
        groundBot.stop()
        groundTop.stop()
        jumpCount = -1
    }
    
    func reStartGame(){
        pointsRaw = 0
        groundTop.removeFromParent()
        groundBot.removeFromParent()
        wallGenerator.removeAllChildren()
        wallGenerator.removeFromParent()
        monsterGenerator.removeAllChildren()
        monsterGenerator.removeFromParent()
        hero.removeFromParent()
        self.removeAllChildren()
        generateWorld(self.view!)
        isStart = false
        isGameOver = false
        jumpCount = -1
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        if (bodyA.categoryBitMask == BodyType.hero.rawValue)
        {
            if bodyB.categoryBitMask == BodyType.power_ups.rawValue
            {
                hero.removePowerUpEffect()
                hero.receivePowerUp((bodyB.node as PowerUps).getType())
                makeTimer(10)
                bodyB.node?.removeFromParent()
            }
            else if bodyB.categoryBitMask == BodyType.monster.rawValue
            {
                if (hero.powerUpStatus == 1)
                {
                    hero.swingSword()
                    (bodyB.node as MALMonster).die()
                }
                else
                {
                    gameOver()
                }
            }
            else if bodyB.categoryBitMask == BodyType.wall.rawValue
            {
                    gameOver()
            }
            
        }
        else if (bodyB.categoryBitMask == BodyType.hero.rawValue)
        {
            if bodyA.categoryBitMask == BodyType.power_ups.rawValue
            {
                hero.removePowerUpEffect()
                hero.receivePowerUp((bodyA.node as PowerUps).getType())
                makeTimer(10)
                bodyA.node?.removeFromParent()
            }
            else if bodyA.categoryBitMask == BodyType.monster.rawValue
            {
                if (hero.powerUpStatus == 1)
                {
                    hero.swingSword()
                    (bodyA.node as MALMonster).die()
                }
                else
                {
                    gameOver()
                }
            }
            else if bodyA.categoryBitMask == BodyType.wall.rawValue
            {
                gameOver()
            }

        }
        else if (bodyA.categoryBitMask == BodyType.monster.rawValue && bodyB.categoryBitMask == BodyType.wall.rawValue)
        {
            (bodyA.node as MALMonster).direction *= -1
            (bodyA.node as MALMonster).resetWalk()
        }
        else if (bodyB.categoryBitMask == BodyType.monster.rawValue && bodyA.categoryBitMask == BodyType.wall.rawValue)
        {
            (bodyB.node as MALMonster).direction *= -1
            (bodyB.node as MALMonster).resetWalk()
        }
    }
    
    func makeTimer(time: Int){
        if timer == nil
        {
            timer = CountDownTimer(time: 10)
            timer!.position = CGPointMake(300, 300)
            addChild(timer!)
        }
        else
        {
            timer?.removeFromParent()
            timer = CountDownTimer(time: 10)
            timer!.position = CGPointMake(300, 320)
            addChild(timer!)
        }
    }
    
    func animationWithPulse(node: SKNode){
        let fadeIn = SKAction.fadeInWithDuration(0.6)
        let fadeOut = SKAction.fadeOutWithDuration(0.6)
        let pulse = SKAction.sequence([fadeIn,fadeOut])
        node.runAction(SKAction.repeatActionForever(pulse))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        pointLabel.updatePoints(pointsRaw - 2)
        if timer != nil && timer!.timeLeft == 0
        {
            timer!.removeFromParent()
            hero.removePowerUpEffect()
        }
    }
}
