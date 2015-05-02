//
//  Constants.swift
//  GoNinja
//
//  Created by uicsi8 on 3/9/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import SpriteKit
import Foundation

// frameSize that is accessible to all files, initialize to be 0
var frameSize:CGSize = CGSizeMake(0.0, 0.0)

let groundHeightFactor:CGFloat = 0.1  // proportion to the screen size
let groundWidthFactor:CGFloat = 2.0

let wallWidthFactor:CGFloat = 0.05
let wallHeightFactorTall:CGFloat = 0.25
let wallHeightFactorLow:CGFloat = 0.15

let gameFont = "AmericanTypewriter-Bold"

//Hero Parameters
let bodyWidthFactor:CGFloat = 40.0/667.0
let bodyHeightFactor:CGFloat = 25.0/375.0
let heroPositionXFactor:CGFloat = 80.0/667.0
let heroPositionYFactor:CGFloat = 54.0/375.0
let headWidthFactor:CGFloat = 50.0/667.0
let headHeightFactor:CGFloat = 50.0/375.0
let headPositionFactor:CGFloat = -5.0/667.0
let faceStartFactor:CGFloat = 1.0/667.0
let faceEndFactor:CGFloat = 40.0/667.0
let faceYFactor:CGFloat = 37.0/375.0
let leftEyeXFactor:CGFloat = 12.5/667.0
let rightEyeXFactor:CGFloat = 23.5/667.0
let eyeYFactor:CGFloat = 25.5/375.0
let eyeSizeXFactor:CGFloat = 4.5/667.0
let eyeSizeYFactor:CGFloat = 4.5/375.0
let leftEyeBrowXFactor:CGFloat = -8.0/667.0
let leftEyeBrowYFactor:CGFloat = 2.0/375.0
let leftEyeBrowPosXFactor:CGFloat = 18.0/667.0
let rightEyeBrowPosXFactor:CGFloat = 22.5/667.0
let eyeBrowPosYFactor:CGFloat = 32.5/375.0
let footHeightFactor:CGFloat = 12.0/375.0
let footWidthFactor:CGFloat = 5.0/667.0
let rightFootAdjustFactor:CGFloat = 0.5/667.0
let anchorPointSizeFactor:CGFloat = 3.0/667.0
let leftAnchorYFactor:CGFloat = 20.0/375.0
let leftArmXFactor:CGFloat = 20.0/600
let ninjaStarSizeFactor:CGFloat = 20.0/667.0
let ninjaStarPosXFactor:CGFloat = 53.0/667.0
let ninjaStarPosYFactor:CGFloat = 5.0/375.0
let ninjaSwordSizeXFactor:CGFloat = 50.0/667.0
let ninjaSwordSizeYFactor:CGFloat = 40.0/375.0
let ninjaSwordPosYFactor:CGFloat = 25.0/375.0
let heroPhysicsWidthFactor:CGFloat = 70.0/667.0
let heroPhysicsHeightFactor:CGFloat = 78.0/375.0
let heroPhysicsCenterXFactor:CGFloat = 23.0/667.0
let heroPhysicsCenterYFactor:CGFloat = 24.0/375.0
let newStarSizeFactor:CGFloat = 30.0/667.0
let newStarPosXFactor:CGFloat = 55.0/667.0
let newStarPosYFactor:CGFloat = 13.0/375.0
let newSwordPosXFactor:CGFloat = 18.0/667.0
let newSwordPosYFactor:CGFloat = 16.0/375.0

//Cloud Parameters
let cloudWidthFactor:CGFloat = 125.0/667.0
let cloudHeightFactor:CGFloat = 55.0/375.0

//Monster Parameters
let monsterWidthFactor:CGFloat = 40.0/667.0
let monsterHeightFactor:CGFloat = 40.0/375.0
let bodyUpCoverHeightFactor:CGFloat = 25.0/375.0
let bodyUpCoverPosYFactor:CGFloat = 7.5/375.0
let monsterRightEyeSizeFactor:CGFloat = 6.0/667.0
let monsterRightEyePosXFactor:CGFloat = 13.0/667.0
let monsterEyePosYFactor:CGFloat = 8.0/375.0
let monsterLeftEyePosXFactor:CGFloat = -3.0/667.0
let mouthWidthFactor:CGFloat = 24.0/667.0
let mouthHeightFactor:CGFloat = 15.0/375.0
let mouthPosXFactor:CGFloat = 8.0/667.0
let mouthPosYFactor:CGFloat = -12.5/375.0
let toothWidthFactor:CGFloat = 6.0/667.0
let toothHeightFactor:CGFloat = 12.0/375.0
let toothPosYFactor:CGFloat = 1.5/375.0
let toothPosXFactor:CGFloat = 3.5/667.0
let monsterChangePosFactor:CGFloat = 125.0/375.0

//Coin Parameters
let coinSizeFactor:CGFloat = 30.0/667.0
let coinPosXFactor:CGFloat = 1000.0/667.0
let coinY1Factor:CGFloat = 323.0/375.0
let coinY2Factor:CGFloat = 52.0/375.0

//Power UP Parameters
let powerUpSizeFactor:CGFloat = 40.0/667.0
let powerUpPosYFactor:CGFloat = 300.0/375.0
let TimerWidthFactor:CGFloat = 20.0/667.0
let TimerHeightFactor:CGFloat = 15.0/375.0
let timerLabelPosXFactor:CGFloat = 18.0/667.0
let timerLabelPosYFactor:CGFloat = -5.0/375.0


//Mechanics Parameters
let swipeUpPosXFactor:CGFloat = 200.0/667.0
let swipeUpPosYFactor:CGFloat = 375.0/375.0
let jumpHeightAdditionFactor:CGFloat = 50.0/375.0

//FrameWork Parameters
let titlelabelPosXFactor:CGFloat = 335.0/667.0
let titlelabelPosYFactor:CGFloat = 280.0/375.0
let startButtonPosXFactor:CGFloat = 280.0/667.0
let startButtonPosYFactor:CGFloat = 150.0/375.0
let HSButtonPosYFactor:CGFloat = 200.0/375.0
let settingsButtonPosYFactor:CGFloat = 175.0/375.0
let buttonWidthFactor:CGFloat = 120.0/667.0
let buttonHeightFactor:CGFloat = 20.0/375.0
let HSBackButtonPosXFactor:CGFloat = 280.0/667.0
let HSBackButtonPosYFactor:CGFloat = 300.0/375.0
let hsLabelPosXFactor:CGFloat = 340.0/667.0
let hsLabelPosYFactor:CGFloat = 300.0/375.0
let hsInitialPosFactor:CGFloat = 250.0/375.0
let hsSlotFactor:CGFloat = 30.0/375.0

let pauseButtonPosXFactor:CGFloat = 30.0/667.0
let pauseButtonSizeFactor:CGFloat = 27.0/667.0

var pointsRaw = 0
var jumpCount = 0

var doublePoints = false

enum BodyType:UInt32 {
    
    case hero = 1
    case wall = 2
    case coin = 4
    case monster = 8
    case power_ups = 16
    case ninjaStar = 32
}

var tutorialOn = true
var tutorialStart = false
var tutorialIndex = 0