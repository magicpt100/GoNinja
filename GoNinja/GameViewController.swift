//
//  GameViewController.swift
//  GoNinja
//
//  Created by uicsi8 on 3/6/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var animator:UIDynamicAnimator!
    var scene : GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
 
        //Configure the view
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        // create and configure teh scene
        scene = GameScene(size: skView.bounds.size)
        //scene.scaleMode = .AspectFill
        
        // set the frameSize
        frameSize = CGSizeMake(skView.frame.size.width, skView.frame.size.height)
        //Present the scene
        skView.showsPhysics = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.presentScene(scene)
    }

    @IBAction func swipeHandler(sender: UIPanGestureRecognizer)
    {
        if !scene.hero.starInAir {
        let rotateCW = SKAction.rotateByAngle(CGFloat(M_PI), duration: 0)
        let rotateCCW = SKAction.rotateByAngle(-CGFloat(M_PI), duration: 0)

        if(sender.velocityInView(view!).y > 0  && scene.hero.onGround == false)
        {
            scene.hero.onGround = true
            scene.hero.runAction(rotateCW)
            scene.hero.position = CGPointMake(0, 0)
            scene.dropSmokeBomb()
        }
        else if(sender.velocityInView(view!).y < 0 && scene.hero.onGround == true)
        {
            scene.hero.onGround = false
            scene.hero.runAction(rotateCCW)
            scene.hero.position = CGPointMake(200, 375)
            scene.dropSmokeBomb()
        }
        }
        if tutorialStart && tutorialIndex == 1 && scene.hero.onGround == false
        {
            scene.swipeUpIcon.hidden = true
            scene.swipeUpInstruction.hidden = true
            scene.swipeDownIcon.hidden = false
            scene.swipeDownInstruction.hidden = false
            tutorialIndex += 1
        }
        else if tutorialStart && tutorialIndex == 2 && scene.hero.onGround == true
        {
            scene.swipeDownIcon.hidden = true
            scene.swipeDownInstruction.hidden = true
            tutorialIndex += 1
            tutorialStart = false
            tutorialOn = false
            scene.reStartGame()
        }
        
        
    }

    @IBAction func tapHandler(sender: UITapGestureRecognizer)
    {
        if scene.hero.powerUpStatus != 3 {
        if (!scene.hero.body.hasActions()) { //Jump not currently in progress
            if (jumpCount > 0) {
                if (jumpCount % 3 == 1) {
                    frontFlip()
                } else if (jumpCount % 3 == 2) {
                    jump()
                } else if (jumpCount % 3 == 0) {
                    backFlip()
                }
            }
            }; jumpCount += 1 }
        else
        {
            scene.hero.throwNinjaStar()
        }
    }
    
    func frontFlip() {
        var wallHeightAverage : CGFloat = ((wallHeightFactorTall + wallHeightFactorLow) / 2)
        var jumpHeight : CGFloat = (frameSize.height * wallHeightAverage) + 50
        
        let up = SKAction.moveByX(0, y: jumpHeight, duration: 0.25)
        let flip = SKAction.rotateByAngle((2 * CGFloat(-M_PI)), duration: 0.3)
        let down = SKAction.moveByX(0, y: -jumpHeight, duration: 0.25)
        
        let jumpSequence = SKAction.sequence([up, flip, down])
        scene.hero.body.runAction(SKAction.repeatAction(jumpSequence, count: 1))
    }
    
    func backFlip() {
        var wallHeightAverage : CGFloat = ((wallHeightFactorTall + wallHeightFactorLow) / 2)
        var jumpHeight : CGFloat = (frameSize.height * wallHeightAverage) + 50
        
        let up = SKAction.moveByX(0, y: jumpHeight, duration: 0.25)
        let flip = SKAction.rotateByAngle((2 * CGFloat(M_PI)), duration: 0.3)
        let down = SKAction.moveByX(0, y: -jumpHeight, duration: 0.25)
        
        let jumpSequence = SKAction.sequence([up, flip, down])
        scene.hero.body.runAction(SKAction.repeatAction(jumpSequence, count: 1))
    }
    
    func jump() {
        var wallHeightAverage : CGFloat = ((wallHeightFactorTall + wallHeightFactorLow) / 2)
        var jumpHeight : CGFloat = (frameSize.height * wallHeightAverage)
        
        let up = SKAction.moveByX(0, y: jumpHeight, duration: 0.25)
        let pause = SKAction.moveByX(0, y: 0, duration: 0.3)
        let down = SKAction.moveByX(0, y: -jumpHeight, duration: 0.25)
        
        let jumpSequence = SKAction.sequence([up, pause, down])
        scene.hero.body.runAction(SKAction.repeatAction(jumpSequence, count: 1))
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
/*
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.Landscape.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
