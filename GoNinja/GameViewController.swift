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
        skView.presentScene(scene)
        

    }

    @IBAction func swipeHandler(sender: UIPanGestureRecognizer)
    {
        scene.hero.dropSmokeBomb()
        let rotateCW = SKAction.rotateByAngle(CGFloat(M_PI), duration: 0)
        let rotateCCW = SKAction.rotateByAngle(-CGFloat(M_PI), duration: 0)

        if(sender.velocityInView(view!).y > 0 && scene.hero.onGround != nil && scene.hero.onGround == false)
        {
            scene.hero.onGround = true
            scene.hero.runAction(rotateCW)
            scene.hero.position = CGPointMake(0, 0)
        }
        else if(sender.velocityInView(view!).y < 0 && scene.hero.onGround != nil && scene.hero.onGround == true)
        {
            scene.hero.onGround = false
            scene.hero.runAction(rotateCCW)
            scene.hero.position = CGPointMake(200, 375)
        }
        
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
