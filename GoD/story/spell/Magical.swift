//
//  Magical.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Magical: Active {
    
    override init() {
        super.init()
        isMagical = true
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

