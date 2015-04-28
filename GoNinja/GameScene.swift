//
//  GameScene.swift
//  GoNinja
//
//  Created by uicsi8 on 3/6/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

//commit-push test by Alex

import SpriteKit
import AVFoundation

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

    var cloudGenerator: MALCloudGenerator!
    var powerUpGenerator: PowerUpGenerator!
    var power: PowerUps!
    var timer: CountDownTimer?
    
    //Audio
    var pauseOn = false
    var muteOn = false
    let muteOnIcon = UIImage(named: "mute on")
    let muteOffIcon = UIImage(named: "mute off")
    var muteButton: UIButton!
    
    //Audio URLs
    var backgroundAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Background", ofType: "mp3")!)
    var startAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Start", ofType: "mp3")!)
    var collisionAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Collision", ofType: "wav")!)
    var bombAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Bomb", ofType: "mp3")!)
    var coinAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Coin", ofType: "mp3")!)
    var jumpAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Jump", ofType: "mp3")!)
    var powerupAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Powerup", ofType: "mp3")!)
    var swordAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Sword", ofType: "mp3")!)
    var starAudioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Star", ofType: "mp3")!)
    
    //Audio Players
    var backgroundAudioPlayer = AVAudioPlayer()
    var startAudioPlayer = AVAudioPlayer()
    var collisionAudioPlayer = AVAudioPlayer()
    var bombAudioPlayer = AVAudioPlayer()
    var coinAudioPlayer = AVAudioPlayer()
    var jumpAudioPlayer = AVAudioPlayer()
    var powerupAudioPlayer = AVAudioPlayer()
    var swordAudioPlayer = AVAudioPlayer()
    var starAudioPlayer = AVAudioPlayer()
    
    //Tutorial Node
    var tapInstructionIcon: SKSpriteNode!
    var tapInstruction: SKLabelNode!
    var swipeUpIcon: SKSpriteNode!
    var swipeUpInstruction: SKLabelNode!
    var swipeDownIcon: SKSpriteNode!
    var swipeDownInstruction: SKLabelNode!
    var powerUpIcon1: SKSpriteNode!
    var powerUpInstruction1:SKLabelNode!
    var powerUpIcon2: SKSpriteNode!
    var powerUpInstruction2:SKLabelNode!
    var powerUpIcon3: SKSpriteNode!
    var powerUpInstruction3:SKLabelNode!
    var monsterIcon:MALMonster!
    var monsterInstruction:SKLabelNode!
    
    
    var titleLabel: SKLabelNode!
    
    var loadMenu = true
    
    var highScoresList: [AnyObject] = []
    
    //Buttons
    var pauseButton: UIButton!
    var startButton: UIButton!
    var resumeButton: UIButton!
    var HSButton: UIButton!
    var HSBackButton: UIButton!
    var HomeButton: UIButton!
    
    //PauseMenu
    var pauseMenu: UIView!
    
    //Start Screen Monster
    var monster: MALMonster!
    
    
    /*
    override init()
    {
        super.init()
        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    override func didMoveToView(view: SKView) {
        
        backgroundAudioPlayer = AVAudioPlayer(contentsOfURL: backgroundAudioURL, error: nil)
        startAudioPlayer = AVAudioPlayer(contentsOfURL: startAudioURL, error: nil)
        collisionAudioPlayer = AVAudioPlayer(contentsOfURL: collisionAudioURL, error: nil)
        bombAudioPlayer = AVAudioPlayer(contentsOfURL: bombAudioURL, error: nil)
        coinAudioPlayer = AVAudioPlayer(contentsOfURL: coinAudioURL, error: nil)
        jumpAudioPlayer = AVAudioPlayer(contentsOfURL: jumpAudioURL, error: nil)
        powerupAudioPlayer = AVAudioPlayer(contentsOfURL: powerupAudioURL, error: nil)
        swordAudioPlayer = AVAudioPlayer(contentsOfURL: swordAudioURL, error: nil)
        starAudioPlayer = AVAudioPlayer(contentsOfURL: starAudioURL, error: nil)
        startAudioPlayer.volume = 0.3
        backgroundAudioPlayer.volume = 0.3
        loadHighScores()
        openMenu(view)
        println(frameSize)
        
    }
    
    func pausePressed(sender:UIButton){
    
        self.paused = true
        pauseMenu = UIView(frame: frame)
        pauseMenu.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        resumeButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        resumeButton.setTitle("Resume", forState: UIControlState.Normal)
        resumeButton.frame = CGRectMake(frameSize.width/2-40, frameSize.height/2 - 20, 80, 20)
        resumeButton.addTarget(self, action: "resume:", forControlEvents: UIControlEvents.TouchUpInside)
        pauseMenu.addSubview(resumeButton)
        self.view?.addSubview(pauseMenu)
        
        HomeButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        HomeButton.setTitle("Home", forState: UIControlState.Normal)
        HomeButton.frame = CGRectMake(frameSize.width/2-40,frameSize.height/2 + 20, 80, 20)
        HomeButton.addTarget(self, action: "goHome:", forControlEvents: UIControlEvents.TouchUpInside)
        pauseMenu.addSubview(HomeButton)
    }
    
    func mutePressed(sender:UIButton){
        if (muteOn == true) {
            muteOn = false
            backgroundAudioPlayer.volume = 0.3
            startAudioPlayer.volume = 0.3
            collisionAudioPlayer.volume = 1.0
            bombAudioPlayer.volume = 1.0
            coinAudioPlayer.volume = 1.0
            jumpAudioPlayer.volume = 1.0
            powerupAudioPlayer.volume = 1.0
            swordAudioPlayer.volume = 1.0
            starAudioPlayer.volume = 1.0
            muteButton.setBackgroundImage(muteOffIcon, forState: UIControlState.Normal)
        }
        else if (muteOn == false) {
            muteOn = true
            backgroundAudioPlayer.volume = 0.0
            startAudioPlayer.volume = 0.0
            collisionAudioPlayer.volume = 0.0
            bombAudioPlayer.volume = 0.0
            coinAudioPlayer.volume = 0.0
            jumpAudioPlayer.volume = 0.0
            powerupAudioPlayer.volume = 0.0
            swordAudioPlayer.volume = 0.0
            starAudioPlayer.volume = 0.0
            muteButton.setBackgroundImage(muteOnIcon, forState: UIControlState.Normal)
        }
    }
    
    func resume(sender:UIButton)
    {
        self.paused = false
        pauseMenu.removeFromSuperview()
    }
    
    func goHome(sender:UIButton)
    {
        pauseMenu.removeFromSuperview()
        self.paused = false
        cleanUp()
        backgroundAudioPlayer.stop()
        loadMenu = true
        loadHighScores()
        openMenu(self.view!)
    }
    
    func startPressed(sender: UIButton)
    {
        loadMenu = false
        startButton.hidden = true
        HSButton.hidden = true
        titleLabel.hidden = true
        hero.removeFromParent()
        monster.removeFromParent()
        
        if(tutorialOn)
        {
            generateWorldWithTutorial(self.view!)
            tutorialOn = false
        }
        else
        {
            startAudioPlayer.stop()
            generateWorld(self.view!)
        }
    }
    
    func HSPressed(sender: UIButton)
    {
        openHighScores(self.view!)
    }
    func HSBackButtonPressed(sender: UIButton)
    {
        self.removeAllChildren()
        HSBackButton.hidden = true
        openMenu(self.view!)
    }

    func applicationDidEnterBackGround (){
        self.paused = !self.paused
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if !tutorialStart
        {
            if !isStart && !loadMenu
            {
                start()
            }
            else if isGameOver
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
            else if tutorialIndex == 3
            {
                monsterIcon.hidden = true
                monsterInstruction.hidden = true
                tutorialIndex += 1
                powerUpIcon1.hidden = false
                powerUpInstruction1.hidden = false
            }
            else if tutorialIndex == 4
            {
                powerUpIcon1.hidden = true
                powerUpInstruction1.hidden = true
                tutorialIndex += 1
                powerUpIcon2.hidden = false
                powerUpInstruction2.hidden = false
            }
            else if tutorialIndex == 5
            {
                powerUpIcon2.hidden = true
                powerUpInstruction2.hidden = true
                tutorialIndex += 1
                powerUpIcon3.hidden = false
                powerUpInstruction3.hidden = false
            }
            else if tutorialIndex == 6
            {
                powerUpIcon3.hidden = true
                powerUpInstruction3.hidden = true
                tutorialIndex += 1
                tutorialStart = false
                tutorialOn = false
                startAudioPlayer.stop()
                reStartGame()
            }
        }
    }
    
    func openMenu(view: SKView)
    {
        let titleLabelPosX = titlelabelPosXFactor * frameSize.width
        let titleLabelPosY = titlelabelPosYFactor * frameSize.height
        let startButtonPosX = startButtonPosXFactor * frameSize.width
        let startButtonPosY = startButtonPosYFactor * frameSize.height
        let startButtonWidth = buttonWidthFactor * frameSize.width
        let startButtonHeight = buttonHeightFactor * frameSize.height
        let HSButtonWidth = buttonWidthFactor * frameSize.width
        let HSButtonPosY = HSButtonPosYFactor * frameSize.height
        
        
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
        hero.startAnimation()
        
        titleLabel = SKLabelNode(text: "Go Ninja!")
        titleLabel.fontColor = UIColor.blackColor()
        titleLabel.fontName = gameFont
        titleLabel.fontSize = 40.0
        titleLabel.position = CGPointMake(titleLabelPosX, titleLabelPosY)
        addChild(titleLabel)
        
        startButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        startButton.frame = CGRectMake(startButtonPosX, startButtonPosY,startButtonWidth, startButtonHeight)
        startButton.setTitle("Start game", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(startButton)
        
        HSButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        HSButton.frame = CGRectMake(startButtonPosX, HSButtonPosY, HSButtonWidth, startButtonHeight)
        HSButton.setTitle("High scores", forState: UIControlState.Normal)
        HSButton.addTarget(self, action: "HSPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(HSButton)
        
        startAudioPlayer.play()
        
        //Add the mute Button
        if muteButton == nil
        {
            let pauseButtonSize = pauseButtonSizeFactor * frameSize.width
            let pauseButtonPosX = pauseButtonPosXFactor * frameSize.width
            muteButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            muteButton.frame = CGRectMake(frameSize.width - pauseButtonPosX, frameSize.height - pauseButtonSize, pauseButtonSize, pauseButtonSize)
            muteButton.setBackgroundImage(muteOffIcon, forState: UIControlState.Normal)
            muteButton.addTarget(self, action: "mutePressed:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view?.addSubview(muteButton)
        }
        
        //Add a monster
        monster = MALMonster(topOrBot: 0)
        monster.position = CGPointMake(frameSize.width * 0.67, frameSize.height/2)
        monster.removeAllActions()
        performOneRunCyle(monster)
        addChild(monster)


        
    }
    
    func loadHighScores()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //defaults.setObject(nil, forKey: "GoNinjaHighScores")//delete high scores
        
        if let loadScores = defaults.arrayForKey("GoNinjaHighScores")
        {
            //println("load list")
            highScoresList = defaults.arrayForKey("GoNinjaHighScores") as! [NSInteger]
        }
        else
        {
            //println("new list")
            highScoresList.append(0)
            highScoresList.append(0)
            highScoresList.append(0)
            highScoresList.append(0)
            highScoresList.append(0)
            
            defaults.setObject(highScoresList, forKey: "GoNinjaHighScores")
            
        }
    }
    
    func openHighScores(view: SKView)
    {
        let HSBackButtonPosX = HSBackButtonPosXFactor * frameSize.width
        let HSBackButtonPosY = HSBackButtonPosYFactor * frameSize.height
        let buttonWidth = buttonWidthFactor * frameSize.width
        let buttonHeight = buttonHeightFactor * frameSize.height
        let hsLabelPosX = hsLabelPosXFactor * frameSize.width
        let hsLabelPosY = hsLabelPosYFactor * frameSize.height
        let hsInitialPos = hsInitialPosFactor * frameSize.height
        let hsSlot = hsSlotFactor * frameSize.height
        
        titleLabel.hidden = true
        HSButton.hidden = true
        startButton.hidden = true
        
        HSBackButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        HSBackButton.frame = CGRectMake(HSBackButtonPosX, HSBackButtonPosY, buttonWidth, buttonHeight)
        HSBackButton.setTitle("Back", forState: UIControlState.Normal)
        HSBackButton.addTarget(self, action: "HSBackButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(HSBackButton)
        
        HSBackButton.hidden = false
        
        let hsLabel = SKLabelNode(text: "High Scores")
        hsLabel.fontColor = UIColor.blackColor()
        hsLabel.fontName = gameFont
        hsLabel.fontSize = 30.0
        
        hsLabel.position = CGPointMake(hsLabelPosX, hsLabelPosY)
        addChild(hsLabel)

        for i in 0...4
        {
            let text = SKLabelNode(text: String(i + 1) + ".   ")
            let score = highScoresList[i].stringValue
            
            if(highScoresList[i] as! Int > 0)
            {
                text.text += score
            }
                
            text.fontColor = UIColor.blackColor()
            text.fontName = gameFont
            text.fontSize = 20.0
            
            var offset: CGFloat = hsInitialPos - (CGFloat(i) * hsSlot)
            
            text.position = CGPointMake(hsLabelPosX, offset)
            addChild(text)

        }
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
        
        //Add Monster instructions
        
        monsterIcon = MALMonster(topOrBot: 0)
        monsterIcon.position = view.center
        monsterIcon.removeAllActions()
        performOneRunCyle(monsterIcon)
        addChild(monsterIcon)
        monsterIcon.hidden = true
        
        monsterInstruction = SKLabelNode(text: "This evil hamster is not your pet! Dodge it or you gonna get bited")
        monsterInstruction.fontColor = UIColor.blackColor()
        monsterInstruction.fontSize = 18.0
        monsterInstruction.fontName = gameFont
        monsterInstruction.position = CGPointMake(view.center.x, view.center.y+40)
        addChild(monsterInstruction)
        animationWithPulse(monsterInstruction)
        monsterInstruction.hidden = true
        
        //Add power Up instructions
        
        //power up 1
        powerUpIcon1 = SKSpriteNode(imageNamed: "powerUp1")
        powerUpIcon1.size = CGSizeMake(40, 40)
        powerUpIcon1.position = view.center
        addChild(powerUpIcon1)
        powerUpIcon1.hidden = true
        
        powerUpInstruction1 = SKLabelNode(text: "The Sword of Magic: Use it to kill monsters")
        powerUpInstruction1.fontColor = UIColor.blackColor()
        powerUpInstruction1.fontName = gameFont
        powerUpInstruction1.fontSize = 20.0
        powerUpInstruction1.position = CGPointMake(view.center.x, view.center.y+40)
        addChild(powerUpInstruction1)
        animationWithPulse(powerUpInstruction1)
        powerUpInstruction1.hidden = true
        
        //power up 2
        powerUpIcon2 = SKSpriteNode(imageNamed: "powerUp2")
        powerUpIcon2.size = CGSizeMake(40, 40)
        powerUpIcon2.position = view.center
        addChild(powerUpIcon2)
        powerUpIcon2.hidden = true
        
        powerUpInstruction2 = SKLabelNode(text: "Ghost Power: You can go through walls!")
        powerUpInstruction2.fontColor = UIColor.blackColor()
        powerUpInstruction2.fontName = gameFont
        powerUpInstruction2.fontSize = 20.0
        powerUpInstruction2.position = CGPointMake(view.center.x, view.center.y+40)
        addChild(powerUpInstruction2)
        animationWithPulse(powerUpInstruction2)
        powerUpInstruction2.hidden = true
        
        //power up 3
        powerUpIcon3 = SKSpriteNode(imageNamed: "powerUp3")
        powerUpIcon3.size = CGSizeMake(40, 40)
        powerUpIcon3.position = view.center
        addChild(powerUpIcon3)
        powerUpIcon3.hidden = true
        
        powerUpInstruction3 = SKLabelNode(text: "Shuriken Master: throw shurikens to break everything")
        powerUpInstruction3.fontColor = UIColor.blackColor()
        powerUpInstruction3.fontName = gameFont
        powerUpInstruction3.fontSize = 20.0
        powerUpInstruction3.position = CGPointMake(view.center.x, view.center.y+40)
        addChild(powerUpInstruction3)
        animationWithPulse(powerUpInstruction3)
        powerUpInstruction3.hidden = true
        tutorialStart = true

    }
    
    func performOneRunCyle(monsterNode:MALMonster)
    {
        let upForward = SKAction.moveByX(8, y: 5, duration: 0.1)
        let downForward = SKAction.moveByX(8, y: -5, duration: 0.1)
        let upForward2 = SKAction.moveByX(-8, y: 5, duration: 0.1)
        let downForward2 = SKAction.moveByX(-8, y: -5, duration: 0.1)
        let walkAnimation = SKAction.sequence([upForward,downForward,upForward,downForward,upForward,downForward,upForward,downForward,upForward,downForward,upForward,downForward,upForward,downForward,upForward,downForward,upForward,downForward])
        let walkAnimation2 = SKAction.sequence([upForward2,downForward2,upForward2,downForward2,upForward2,downForward2,upForward2,downForward2,upForward2,downForward2,upForward2,downForward2,upForward2,downForward2,upForward2,downForward2,upForward2,downForward2])
        monsterNode.runAction(walkAnimation, completion: { () -> Void in
            (monsterNode).direction *= -1
            (monsterNode).changeFace()
            monsterNode.runAction(walkAnimation2, completion: { () -> Void in
                (monsterNode).direction *= -1
                (monsterNode).changeFace()
                self.performOneRunCyle(monsterNode)
            })
        })

    }
    
    func generateWorld(view:SKView)
    {
        self.removeAllChildren()
        // Set the background
        backgroundColor = UIColor(red: 0.54, green: 0.7853, blue: 1.0, alpha: 1.0)
        
        //Set the physics
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, -6)
        
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
        let pauseButtonPosX = pauseButtonPosXFactor * frameSize.width
        let pauseButtonSize = pauseButtonSizeFactor * frameSize.width
        let pauseIcon = UIImage(named: "pauseIcon")
        pauseButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        pauseButton.frame = CGRectMake(frameSize.width - pauseButtonPosX, 0, pauseButtonSize, pauseButtonSize)
        pauseButton.setBackgroundImage(pauseIcon, forState: UIControlState.Normal)
        pauseButton.addTarget(self, action: "pausePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(pauseButton)
                
        //Add Monster Generator
        monsterGenerator = MALMonsterGenerator()
        addChild(monsterGenerator)
        
        //Add power-Ups
        powerUpGenerator = PowerUpGenerator()
        addChild(powerUpGenerator)
        
        //hero.receivePowerUp(3)
        
        
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
        backgroundAudioPlayer.play()
    }
    
    func gameOver(){
        isGameOver = true
        var gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontName = gameFont
        gameOverLabel.fontColor = UIColor.blackColor()
        gameOverLabel.position = CGPointMake(frameSize.width/2, frameSize.height/2)
        addChild(gameOverLabel)
        animationWithPulse(gameOverLabel)
        hero.fall()
        wallGenerator.stop()
        coinGenerator.stopMoving()
        monsterGenerator.stop()
        powerUpGenerator.stop()
        groundBot.stop()
        groundTop.stop()
        pauseButton.removeFromSuperview()
        if timer != nil
        {
            timer!.removeFromParent()
        }
        jumpCount = -1
        
        updateHighScores(pointLabel.text.toInt()!)
        backgroundAudioPlayer.stop()
    }
    
    func updateHighScores(score: Int)
    {
        //println(highScoresList)
        //highScoresList.append(score)
        //println(highScoresList)
        
        var intScores = highScoresList as! [Int]
        intScores.append(score)
        
        sort(&intScores)
        
        intScores = intScores.reverse()
        
        //println(intScores)
        
        
        for i in 0...4
        {
            highScoresList[i] = intScores[i]
        }
        
        NSUserDefaults.standardUserDefaults().setObject(highScoresList, forKey: "GoNinjaHighScores")
    }
    
    func reStartGame(){
        cleanUp()
        if(loadMenu)
        {
            openMenu(self.view!)
        }
        else
        {
            generateWorld(self.view!)
        }
        backgroundAudioPlayer.stop()
        backgroundAudioPlayer.currentTime = 0
        backgroundAudioPlayer.play()
    }
    
    func cleanUp()
    {
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
        if pauseButton != nil{
            pauseButton.removeFromSuperview()
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
                powerupAudioPlayer.play()
                hero.removePowerUpEffect()
                hero.receivePowerUp((bodyB.node as! PowerUps).getType())
                makeTimer(10)
                bodyB.node?.removeFromParent()
            }
            else if bodyB.categoryBitMask == BodyType.monster.rawValue
            {
                if (hero.powerUpStatus == 1)
                {
                    swordAudioPlayer.play()
                    hero.swingSword()
                    (bodyB.node as! MALMonster).die()
                }
                else
                {
                    collisionAudioPlayer.play()
                    gameOver()
                }
            }
            else if bodyB.categoryBitMask == BodyType.wall.rawValue
            {
                    collisionAudioPlayer.play()
                    gameOver()
            }
            else if(bodyB.categoryBitMask == BodyType.coin.rawValue)
            {
                coinAudioPlayer.play()
                pointsRaw += 1
                (bodyB.node as! Coin).removeFromParent()
            }
            
        }
        else if (bodyB.categoryBitMask == BodyType.hero.rawValue)
        {
            if bodyA.categoryBitMask == BodyType.power_ups.rawValue
            {
                powerupAudioPlayer.play()
                hero.removePowerUpEffect()
                hero.receivePowerUp((bodyA.node as! PowerUps).getType())
                makeTimer(10)
                bodyA.node?.removeFromParent()
            }
            else if bodyA.categoryBitMask == BodyType.monster.rawValue
            {
                if (hero.powerUpStatus == 1)
                {
                    swordAudioPlayer.play()
                    hero.swingSword()
                    (bodyA.node as! MALMonster).die()
                }
                else
                {
                    collisionAudioPlayer.play()
                    gameOver()
                }
            }
            else if bodyA.categoryBitMask == BodyType.wall.rawValue
            {
                collisionAudioPlayer.play()
                gameOver()
            }
            else if(bodyA.categoryBitMask == BodyType.coin.rawValue)
            {
                coinAudioPlayer.play()
                pointsRaw += 1
                (bodyA.node as! Coin).removeFromParent()
            }

        }
        else if (bodyA.categoryBitMask == BodyType.monster.rawValue && bodyB.categoryBitMask == BodyType.wall.rawValue)
        {
            (bodyA.node as! MALMonster).direction *= -1
            (bodyA.node as! MALMonster).resetWalk()
        }
        else if (bodyB.categoryBitMask == BodyType.monster.rawValue && bodyA.categoryBitMask == BodyType.wall.rawValue)
        {
            (bodyB.node as! MALMonster).direction *= -1
            (bodyB.node as! MALMonster).resetWalk()
        }
        else if (bodyA.categoryBitMask == BodyType.ninjaStar.rawValue)
        {
            if bodyB.categoryBitMask == BodyType.monster.rawValue
            {
                (bodyB.node as! MALMonster).die()
                starAudioPlayer.play()
            }
            else
            {
                bodyB.node!.removeFromParent()
                starAudioPlayer.play()
            }
            //hero.restoreStar()
        }
        else if (bodyB.categoryBitMask == BodyType.ninjaStar.rawValue)
        {
            if bodyA.categoryBitMask == BodyType.monster.rawValue
            {
                (bodyA.node as! MALMonster).die()
                starAudioPlayer.play()
            }
            else
            {
                bodyA.node!.removeFromParent()
                starAudioPlayer.play()
            }
            //hero.restoreStar()
        }
    }
    
    func makeTimer(time: Int){
        if timer == nil
        {
            timer = CountDownTimer(time: 10)
            timer!.position = CGPointMake(frameSize.width/2, (1-groundHeightFactor/2) * frameSize.height)
            addChild(timer!)
        }
        else
        {
            timer?.removeFromParent()
            timer = CountDownTimer(time: 10)
            timer!.position = CGPointMake(frameSize.width/2, (1-groundHeightFactor/2) * frameSize.height)
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
            smokeBomb.position = CGPointMake(heroPositionXFactor * frameSize.width, 30)
        }
        else
        {
            smokeBomb.position = CGPointMake(heroPositionYFactor * frameSize.height, 350)
        }
        bombAudioPlayer.currentTime = 0
        bombAudioPlayer.play()
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
        
        if (hero.newStar.position.y + hero.body.position.y) < 0 || (hero.newStar.position.y + hero.body.position.y) > frameSize.height{
            hero.restoreStar()
        }
        
        if hero.starInAir && !hero.onGround
        {
            hero.newStar.physicsBody!.applyForce(CGVectorMake(0,36))
        }
        
    }
}
