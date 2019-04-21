//
//  ThunderPower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ThunderPower: Attribute {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "雷电伤害"
    }
    override func on(unit: Creature) {
        unit._elementalPower.thunder += _value
    }
    
    override func off(unit: Creature) {
        unit._elementalPower.thunder -= _value
    }
    override func create(level: CGFloat) {
        elementalAttrValue(level: level)
    }
}
