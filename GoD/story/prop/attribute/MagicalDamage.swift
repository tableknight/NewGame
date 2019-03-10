//
//  MagicalDamage.swift
//  GoD
//
//  Created by kai chen on 2019/3/5.
//  Copyright © 2019年 Chen. All rights reserved.
//


import SpriteKit
class MagicalDamage: Attribute {
    override init() {
        super.init()
        _name = "法术穿透"
    }
    override func on(unit: Creature) {
        unit._power += _value
    }
    
    override func off(unit: Creature) {
        unit._power -= _value
    }
    override func create(level: CGFloat) {
        _value = seedFloat(min: 1, max: 6)
    }
    
    override func getText() -> String {
        return "\(_name) +\(_value.toInt())%"
    }
}
