//
//  MALPointLabel.swift
//  GoNinja
//
//  Created by uicsi8 on 3/22/15.
//  Copyright (c) 2015 University of Iowa. All rights reserved.
//

import Foundation
import SpriteKit

class MALPointLabel: SKLabelNode {
    var points: Int = 0
    
    override init(fontNamed fontName: String!) {
        super.init()
        self.fontName = fontName
        self.fontSize = 30.0
        self.text = "0"
    }
    
    func increment(){
        points += 1
        self.text = String(points)
    }
    
    func addPoints(number:Int){
        points += number
        self.text = String(points)
    }
    
    func updatePoints(number:Int)
    {
        if (number < 0)
        {
            return
        }
        points = number
        self.text = String(points)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}