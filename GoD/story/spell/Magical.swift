//
//  Magical.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Magical: Spell {
    
    override init() {
        super.init()
        isMagical = true
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}

