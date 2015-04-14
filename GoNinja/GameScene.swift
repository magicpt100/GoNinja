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
    var coinGenerator: CoinGenerator!
    var monsterGenerator: MALMonsterGenerator!
    var hero: MALHero!
    var tapToStartLabel: SKLabelNode!
    var pointLabel: MALPointLabel!
    var isStart = false
    var isGameOver = false
    var pauseButton: UIButton!
    var startButton: UIButton!
    var cloudGenerator: MALCloudGenerator!
    var powerUpGenerator: PowerUpGenerator!
    var power: PowerUps!
    var timer: CountDownTimer?
    
    //Tutorial Node
    var tapInstructionIcon: SKSpriteNode!
    var tapInstruction: SKLabelNode!
    var swipeUpIcon: SKSpriteNode!
    var swipeUpInstruction: SKLabelNode!
    var swipeDownIcon: SKSpriteNode!
    var swipeDownInstruction: SKLabelNode!
    
    var loadMenu = true
    
    
    override func didMoveToView(view: SKView) {
        if tutorialOn
        {
            generateWorldWithTutorial(view)
        }
        else
        {
            generateWorldWithMenu(view)
        }

    }
    
    func pausePressed(sender:UIButton){
        self.paused = !self.paused
    }
    
    func startPressed(sender: UIButton)
    {
        loadMenu = false
        startButton.removeFromSuperview()
        hero.removeFromParent()
        generateWorld(self.view!)
    }
    
    func applicationDidEnterBackGround (){
        self.paused = !self.paused
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if !tutorialStart
        {
            if !isStart && !loadMenu
            {
                start()
            }
            if isGameOver
            {
                reStartGame()
            }
        }
        else
        {
            if tutorialIndex == 0
            {
                tapInstructionIcon.hidden = true
                tapInstruction.hidden = true
                tutorialIndex += 1
                swipeUpIcon.hidden = false
                swipeUpInstruction.hidden = false
            }
        }
    }
    
    func generateWorldWithMenu(view: SKView)
    {
        backgroundColor = UIColor(red: 0.54, green: 0.7853, blue: 1.0, alpha: 1.0)

        // Add the ground
        groundTop = MALGround()
        groundTop.position = CGPointMake(0, view.frame.height - groundTop.frame.size.height/2)
        groundBot = MALGround()
        groundBot.position = CGPointMake(0, groundBot.frame.size.height/2)
        addChild(groundTop)
        addChild(groundBot)
        
        //Add hero
        hero = MALHero()
        addChild(hero)
        hero.breathe()
        
        startButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        startButton.frame = CGRectMake(30, 100, 80, 20)
        startButton.setTitle("Start game", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(startButton)
    }
    
    func generateWorldWithTutorial(view:SKView)
    {
        backgroundColor = UIColor(red: 0.54, green: 0.7853, blue: 1.0, alpha: 1.0)
        
        // Add the ground
        groundTop = MALGround()
        groundTop.position = CGPointMake(0, view.frame.height - groundTop.frame.size.height/2)
        groundBot = MALGround()
        groundBot.position = CGPointMake(0, groundBot.frame.size.height/2)
        addChild(groundTop)
        addChild(groundBot)
        
        //Add hero
        hero = MALHero()
        addChild(hero)
        hero.breathe()
        
        //Add the first instruction: tap
        tapInstructionIcon = SKSpriteNode(imageNamed: "tap")
        tapInstructionIcon.size = CGSizeMake(40, 40)
        tapInstructionIcon.position = view.center
        addChild(tapInstructionIcon)
        tapInstructionIcon.hidden = false
        animationWithPulse(tapInstructionIcon)
        
        tapInstruction = SKLabelNode(text: "Tap to Jump")
        tapInstruction.fontColor = UIColor.blackColor()
        tapInstruction.fontName = gameFont
        tapInstruction.fontSize = 20.0
        tapInstruction.position = CGPointMake(view.center.x, view.center.y + 40)
        tapInstruction.hidden = false
        addChild(tapInstruction)
        animationWithPulse(tapInstruction)
        
        //Add the second instruction: swipe up
        swipeUpIcon = SKSpriteNode(imageNamed: "swipeUp")
        swipeUpIcon.size = CGSizeMake(40, 40)
        swipeUpIcon.position = view.center
        swipeUpIcon.hidden = true
        addChild(swipeUpIcon)
        animationWithPulse(swipeUpIcon)
        
        swipeUpInstruction = SKLabelNode(text: "swipe up to the top side")
        swipeUpInstruction.fontColor = UIColor.blackColor()
        swipeUpInstruction.fontName = gameFont
        swipeUpInstruction.fontSize = 20.0
        swipeUpInstruction.position = CGPointMake(view.center.x, view.center.y + 40)
        swipeUpInstruction.hidden = true
        addChild(swipeUpInstruction)
        animationWithPulse(swipeUpInstruction)
        
        //Add the third instruction: swipe down
        swipeDownIcon = SKSpriteNode(imageNamed: "swipeDown")
        swipeDownIcon.size = CGSizeMake(40, 40)
        swipeDownIcon.position = view.center
        swipeDownIcon.hidden = true
        addChild(swipeDownIcon)
        animationWithPulse(swipeDownIcon)
        
        swipeDownInstruction = SKLabelNode(text: "swipe down to the bottom side")
        swipeDownInstruction.fontColor = UIColor.blackColor()
        swipeDownInstruction.fontName = gameFont
        swipeDownInstruction.fontSize = 20.0
        swipeDownInstruction.position = CGPointMake(view.center.x, view.center.y + 40)
        swipeDownInstruction.hidden = true
        addChild(swipeDownInstruction)
        animationWithPulse(swipeDownInstruction)
        
        tutorialStart = true

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
        
        coinGenerator = CoinGenerator()
        addChild(coinGenerator)
        
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
        tapToStartLabel.zPosition = 1
        tapToStartLabel.fontName = gameFont
        tapToStartLabel.fontSize = CGFloat(20.0)
        tapToStartLabel.fontColor = UIColor.blackColor()
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
        coinGenerator.startGeneratingCoins()
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
        coinGenerator.stopMoving()
        monsterGenerator.stop()
        powerUpGenerator.stop()
        groundBot.stop()
        groundTop.stop()
        jumpCount = -1
    }
    
    func reStartGame(){
        pointsRaw = 0
        groundTop.removeFromParent()
        groundBot.removeFromParent()
        if wallGenerator != nil
        {
            wallGenerator.removeAllChildren()
            wallGenerator.removeFromParent()
        }
        if monsterGenerator != nil
        {
            monsterGenerator.removeAllChildren()
            monsterGenerator.removeFromParent()
        }
        hero.removeFromParent()
        self.removeAllChildren()
        
        if(loadMenu)
        {
            generateWorldWithMenu(self.view!)
        }
        else
        {
            generateWorld(self.view!)
        }
        
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
            else if(bodyB.categoryBitMask == BodyType.coin.rawValue)
            {
                pointsRaw += 1
                (bodyB.node as Coin).removeFromParent()
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
            else if(bodyA.categoryBitMask == BodyType.coin.rawValue)
            {
                pointsRaw += 1
                (bodyA.node as Coin).removeFromParent()
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
    
    func dropSmokeBomb()
    {
        if loadMenu
        {
            return
        }
        
        var smokeBomb = SKEmitterNode(fileNamed: "SmokeBombEffect.sks")
        smokeBomb.particleColorSequence = nil
        smokeBomb.particleColorBlendFactor = 0.5
        smokeBomb.particleColor = UIColor.grayColor()
        
        if hero.onGround == false
        {
            smokeBomb.position = CGPointMake(80, 30)
        }
        else
        {
            smokeBomb.position = CGPointMake(80, 350)
        }
        addChild(smokeBomb)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_MSEC * 500))
        dispatch_after(delayTime, dispatch_get_main_queue(), {smokeBomb.removeFromParent()})
        
    }
    
    func animationWithPulse(node: SKNode){
        let fadeIn = SKAction.fadeInWithDuration(0.6)
        let fadeOut = SKAction.fadeOutWithDuration(0.6)
        let pulse = SKAction.sequence([fadeIn,fadeOut])
        node.runAction(SKAction.repeatActionForever(pulse))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if pointLabel != nil
        {
            pointLabel.updatePoints(pointsRaw - 2)
        }
        if timer != nil && timer!.timeLeft == 0
        {
            timer!.removeFromParent()
            hero.removePowerUpEffect()
        }
    }
}
