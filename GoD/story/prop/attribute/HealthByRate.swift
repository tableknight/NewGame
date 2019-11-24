//
//  HealthByRate.swift
//  GoD
//
//  Created by kai chen on 2019/11/9.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class HealthByRate: Attribute {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "生命上限"
        _hidden = true
    }
    override func on(unit: Creature) {
        _reserve1 = unit._extensions.health * _value / 100
        unit._extensions.health += _reserve1
    }
    
    override func off(unit: Creature) {
        unit._extensions.health -= _reserve1
        if unit._extensions.hp > unit._extensions.health {
            unit._extensions.hp = unit._extensions.health
        }
    }
    override func create(level: CGFloat) {
//        _value = seed(min: level.toInt(), max: (level * 2).toInt()).toFloat()
    }
    override func getText() -> String {
        return "\(_name) +\(_value.toInt())%"
    }
}
