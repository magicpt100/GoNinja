//
//  CountDownTimer.swift
//  GoNinja
//
//  Created by uicsi8 on 4/11/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class CountDownTimer:SKSpriteNode{
    var timerLabel: SKLabelNode!
    var timeLeft:Int = 0
    let timerWidth = TimerWidthFactor * frameSize.width
    let timerHeight = TimerHeightFactor * frameSize.height
    let timerLabelPosX = timerLabelPosXFactor * frameSize.width
    let timerLabelPosY = timerLabelPosYFactor * frameSize.height
    
    init(time:Int)
    {
        super.init(texture: SKTexture(imageNamed: "hourGlass"), color: UIColor.yellowColor(), size: CGSizeMake(timerWidth, timerHeight)  )
        timeLeft = time
        timerLabel = SKLabelNode(fontNamed: gameFont)
        timerLabel.text = String(timeLeft)
        timerLabel.fontSize = 15
        timerLabel.fontColor = UIColor.yellowColor()
        timerLabel.position = CGPointMake(timerLabelPosX, timerLabelPosY)
        timerLabel.zPosition = 5
        addChild(timerLabel)
        run()
    }
    func run()
    {
        var countTimeAction = SKAction.sequence([SKAction.waitForDuration(1.0),SKAction.runBlock(updateTime)])
        self.runAction(SKAction.repeatActionForever(countTimeAction))
    }
    
    func updateTime() {
        if timeLeft > 0
        {
            timeLeft -= 1
            timerLabel.text = String(timeLeft)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}