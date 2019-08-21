//
//  Lucky.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Lucky: Attribute {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "幸运"
    }
    override func on(unit: Creature) {
        unit._lucky += _value
    }
    
    override func off(unit: Creature) {
        unit._lucky -= _value
    }
    override func create(level: CGFloat) {
        lowLevelValue(level: level)
    }
}
