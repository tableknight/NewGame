//
//  Rhythm.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/6/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Rhythm: Attribute {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "律动"
    }
    override func on(unit: Creature) {
        unit._rhythm += _value
    }
    
    override func off(unit: Creature) {
        unit._rhythm -= _value
    }
    override func create(level: CGFloat) {
        lowLevelValue(level: level)
    }
}

