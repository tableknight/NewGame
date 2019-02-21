//
//  FirePower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FirePower: Attribute {
    override init() {
        super.init()
        _name = "火焰伤害"
    }
    override func on(unit: Creature) {
        unit._elementalPower.fire += _value
    }
    
    override func off(unit: Creature) {
        unit._elementalPower.fire -= _value
    }
    override func create(level: CGFloat) {
        elementalAttrValue(level: level)
    }
}
