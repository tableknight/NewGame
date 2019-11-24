//
//  Stamina.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Stamina: Attribute {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "防御"
    }
    override func on(unit: Creature) {
//        unit._mains.stamina += _value
        unit.staminaChange(value: _value)
    }
    
    override func off(unit: Creature) {
//        unit._mains.stamina -= _value
        unit.staminaChange(value: -_value)
    }
    override func create(level: CGFloat) {
        midAttrValue(level: level)
    }
}
