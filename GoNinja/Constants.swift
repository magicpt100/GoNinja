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
let wallHeightFactorTall:CGFloat = 0.30
let wallHeightFactorLow:CGFloat = 0.15

let gameFont = "AmericanTypewriter-Bold"

var pointsRaw = 0
var jumpCount = 0

enum BodyType:UInt32 {
    
    case hero = 1
    case wall = 2
}